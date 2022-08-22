//
//  Service.swift
//  Blink
//
//  Created by Michael Abrams on 8/8/22.
//


import FirebaseStorage
import FirebaseAuth
import UIKit
import Geofirestore
import CoreLocation
import FirebaseFirestore

public class Service {
    
    public typealias Swipes = [String: Bool]
    
    public static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            guard error == nil else {
                print("DEBUG: Error uploading image \(error?.localizedDescription ?? "")")
                return
            }
            
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
            
        }
    }
    
    public static func saveUserData(for user: User, completion: @escaping (Error?) -> Void) {
        user.genderCollection.document(user.uid).updateData(user.getUserNode(), completion: completion)
    }
    
    public static func fetchUsers(for user: User, completion: @escaping ([User]) -> Void) {
        
        //Initalize users
        var users = [User]()
        
        //Create circle query
        let circleQuery = user.locationCollection.query(withCenter: user.centerLocation,
                                                 radius: Double(user.userSettings.distanceRange))
        
        let group = DispatchGroup()
        
        fetchSwipes { swipes in
            _ = circleQuery.observe(.documentEntered) { (key: String!, _) in
                group.enter()
                //Unwrap the key
                guard let safeKey = key else { group.leave(); return }
                
                user.preferenceCollection.document("\(safeKey)").getDocument { snapshot, error in
                    
                    print("DEBUG: Found location for key \(safeKey)")
                    
                    guard let userNode = snapshot?.data(),
                          let searchedUser = User(with: userNode),
                          let age = searchedUser.userProfile.age else { group.leave(); return }
                    
                    print("DEBUG: Made user")
                    
                    if(age > user.userSettings.maxSeekingAge) { group.leave(); return }
                    if(age < user.userSettings.minSeekingAge) { group.leave(); return }
                    if(searchedUser.uid == user.uid) { group.leave(); return }
                    if(swipes[searchedUser.uid] != nil) { group.leave(); return }
                    
                    print("DEBUG: Appending user \(searchedUser.userProfile.firstName)")
                    
                    //Append the user
                    users.append(searchedUser)
                    
                    group.leave()
                }
            }
            
            //CALLED WHEN EVERYONE HAS BEEN FETCHED
            _ = circleQuery.observeReady {
                group.notify(queue: .main) {
                    completion(users)
                }
            }
        }
    }
    
    public static func uploadMatch(currentUser: User, matchedUser: User) {
        guard let otherImageUrl = matchedUser.userProfile.profilePictures.first else { return }
        guard let currentImageUrl = currentUser.userProfile.profilePictures.first else { return }
        
        let matchedUserData = Match(name: matchedUser.userProfile.firstName,
                                 profileImageUrl: otherImageUrl,
                                 uid: matchedUser.uid,
                                 beganConversation: false)
        
        COLLECTION_MATCHES.document(currentUser.uid).collection(MATCHES).document(matchedUser.uid).setData(matchedUserData.getMatchNode())
        
        let currentUserData = Match(name: currentUser.userProfile.firstName,
                                 profileImageUrl: currentImageUrl,
                                 uid: currentUser.uid,
                                 beganConversation: false)
        
        COLLECTION_MATCHES.document(matchedUser.uid).collection(MATCHES).document(currentUser.uid).setData(currentUserData.getMatchNode())
    }
    
    public static func checkIfMatchExists(forUser user: User, completion: @escaping(Bool) -> Void) {
        
        //Grab current user uid
        guard let uid = Auth.auth().currentUser?.uid else { completion(false); return }
        
        //Getting other user's swipe collection
        COLLECTION_SWIPES.document(user.uid).getDocument { snapshot, error in
            //Get swipes from data
            guard let swipes = snapshot?.data() as? Swipes else { completion(false); return }
                
            //If in swipes and true
            completion(swipes[uid] != nil && swipes[uid] == true)

        }
    }
    
    public static func getMatchesForUser(completion: @escaping ([Match]) -> Void) {
        
        //Create a list of matches
        var matches = [Match]()
        
        //Grab uid
        guard let uid = Auth.auth().currentUser?.uid else { completion(matches); return }
        
        //Search all matches
        COLLECTION_MATCHES
            .document(uid)
            .collection(MATCHES)
            .whereField(BEGAN_CONVERSATION, isEqualTo: false)
            .addSnapshotListener(includeMetadataChanges: true) { matchCollection, error in
            
            //If error, return empty matches
            guard error == nil else { completion(matches); return }

            //For each match in the match collection
            matches = matchCollection?.documents.map({ match in
                return Match(with: match.data())
            }) ?? []
            
            //Return matches
            completion(matches)

        }
    }
    
    public static func getConversationsForUser(completion: @escaping ([Conversation]) -> Void) {
        
        //Fetch user
        guard let user = RegistrationManager.shared.getCurrentUser() else { completion([]); return }
        
        user.genderCollection.document(user.uid).collection(CONVERSATIONS).document(CONVERSATIONS)
            .addSnapshotListener(includeMetadataChanges: true) { snapshot, error in
                
                //Check for errors
                guard error == nil,
                      let conversationNode = snapshot?.data(),
                      let conversations = conversationNode[CONVERSATIONS] as? [[String: Any]] else { completion([]); return }
                
                //Read all conversations
                completion(conversations.map({Conversation(conversationDictionary: $0)}))
        }
        
    }
    
    public static func createConversation(sendTo reciever: User,
                                          from sender: User,
                                          message: Message,
                                          completion: @escaping (String?) -> Void) {
        
        //Create the conversation id
        let conversationId = UUID().uuidString
        
        //The conversation under the recievers data
        let recieversConversation = reciever.createConversationNode(for: sender,
                                                                    message: message,
                                                                    id: conversationId)
        
        //The conversation under the sender's data
        let senderConversation = sender.createConversationNode(for: reciever,
                                                               message: message,
                                                               id: conversationId)
        
        //Update reciever conversation
        reciever.genderCollection
            .document(reciever.uid).collection(CONVERSATIONS).document(CONVERSATIONS)
            .setData(recieversConversation, merge: true)
        
        //Update the sender's conversation
        sender.genderCollection
            .document(sender.uid).collection(CONVERSATIONS).document(CONVERSATIONS)
            .setData(senderConversation, merge: true)
        
        //Create conversation collection
        COLLECTION_CONVERSATIONS.document(conversationId)
            .setData([MESSAGES: [message.createMessageNode(from: conversationId)]], merge: true)
        
        
        //Update match to began conversation for reciever
        COLLECTION_MATCHES.document(reciever.uid).collection(MATCHES).document(sender.uid).updateData([BEGAN_CONVERSATION: true])
        
        //Update match to began conversation for sender
        COLLECTION_MATCHES.document(sender.uid).collection(MATCHES).document(reciever.uid).updateData([BEGAN_CONVERSATION: true])
        
        //Return the conversation Id
        completion(conversationId)
        
    }
    
    public static func loadConversation(from conversationId: String,
                                        completion: @escaping ([Message]) -> Void) {
        
        var messages: [Message] = []

        COLLECTION_CONVERSATIONS.document(conversationId).addSnapshotListener(includeMetadataChanges: true) { snapshot, error in
            
            //If there is an error
            guard error == nil else { completion(messages); return }
            
            //Get the messages from document
            guard let conversation = snapshot?.data(),
                  let convoMessages = conversation[MESSAGES] as? [[String: Any]] else {completion(messages); return}
            
            //Convert into messages
            messages = convoMessages.map({Message(with: $0)})
            
            //Return messages from conversation
            completion(messages)

        }
    }
    
    public static func sendMessage(to conversationId: String, message: Message) {
        
        COLLECTION_CONVERSATIONS.document(conversationId).updateData([
            MESSAGES: FieldValue.arrayUnion([message.createMessageNode(from: conversationId)] as [Any])
        ])
        
    }
    
    public static func saveSwipe(forUser user: User, isLike: Bool, completion: ((Error?) -> Void)?) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_SWIPES.document(uid).getDocument { snapshot, error in
            let data = [user.uid: isLike]
            
            if snapshot?.exists == true {
                COLLECTION_SWIPES.document(uid).updateData(data, completion: completion)
            }
            else {
                COLLECTION_SWIPES.document(uid).setData(data, completion: completion)
            }
            
        }
        
    }
    
    private static func fetchSwipes(completion: @escaping (Swipes) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_SWIPES.document(uid).getDocument { snapshot, error in
            guard let swipes = snapshot?.data() as? [String: Bool] else {
                completion([String: Bool]())
                return
            }
            
            completion(swipes)
        }
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
        
        COLLECTION_MALE_USERS.document(uid).getDocument { (snapshot, error) in
            
            if let userNode = snapshot?.data() {
                guard let user = User(with: userNode) else {
                    print("DEBUG: Failed to create user")
                    return
                }
                completion(user)
            }
            else {
                COLLECTION_FEMALE_USERS.document(uid).getDocument { snapshot, error in
                    guard let userNode = snapshot?.data() else {
                        print("DEBUG: No user node found")
                        return
                    }
                    guard let user = User(with: userNode) else {
                        print("DEBUG: Failed to create user")
                        return
                    }
                    
                    completion(user)
                }
            }
        }
    }
}
