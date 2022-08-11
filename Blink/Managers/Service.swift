//
//  Service.swift
//  Blink
//
//  Created by Michael Abrams on 8/8/22.
//


import FirebaseStorage
import FirebaseAuth
import UIKit

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
    
//    static func fetchUsers(forCurrentUser user: User, completion: @escaping([User]) -> Void) {
//        var users = [User]()
//
//        let minAge = user.userSettings.minSeekingAge
//        let maxAge = user.userSettings.maxSeekingAge
//        let collection = user.userSettings.gender == .male ? COLLECTION_MALE_USERS : COLLECTION_FEMALE_USERS
//
//        let query = collection
//            .whereField("age", isGreaterThanOrEqualTo: minAge)
//            .whereField("age", isLessThanOrEqualTo: maxAge)
//
//        query.getDocuments { snapshot, error in
//            guard let snapshot = snapshot else { return }
//            snapshot.documents.forEach({ document in
//                let userNode = document.data()
//                let user = User(userNode: userNode)
//
//                guard user.uid != Auth.auth().currentUser?.uid else { return }
//
//                users.append(user)
//
//                if(users.count == snapshot.documents.count - 1) {
//                    completion(users)
//                }
//            })
//        }
//    }
    
}
