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
    
    static func fetchUsers(for user: User, completion: @escaping ([User]) -> Void) {
        
        //Initalize users
        var users = [User]()
        
        //Create circle query
        let circleQuery = user.locationCollection.query(withCenter: user.centerLocation,
                                                 radius: Double(user.userSettings.distanceRange))
        
        circleQuery.observe(.documentEntered) { (key: String!, _) in

            //Unwrap the key
            guard let safeKey = key else { return }
            
            user.genderedCollection.document("\(safeKey)").getDocument { snapshot, error in
                
                guard let userNode = snapshot?.data(),
                      let searchedUser = User(with: userNode),
                      let age = searchedUser.userProfile.age else { return }
                
                if(age > user.userSettings.maxSeekingAge) { return }
                if(age < user.userSettings.minSeekingAge) { return }
                if(searchedUser.uid == user.uid) { return }
                
                //Append the user
                users.append(user)

            }
            
        }
        
        //CALLED WHEN ALL KEYS HAVE BEEN OBSERVED
        circleQuery.observeReady {
            completion(users)
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
