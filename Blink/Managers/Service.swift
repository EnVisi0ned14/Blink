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
                                 uid: matchedUser.uid)
        
        COLLECTION_MATCHES.document(currentUser.uid).collection(MATCHES).document(matchedUser.uid).setData(matchedUserData.getMatchNode())
        
        let currentUserData = Match(name: currentUser.userProfile.firstName,
                                 profileImageUrl: currentImageUrl,
                                 uid: currentUser.uid)
        
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
