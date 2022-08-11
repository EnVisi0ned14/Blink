//
//  RegistrationManager.swift
//  Blink
//
//  Created by Michael Abrams on 8/8/22.
//

import Foundation
import FirebaseAuth
import GeoFire
import FirebaseFirestore

public class RegistrationManager {
    
    public static let shared = RegistrationManager()
    
    
    private var currentUser: User?
    
    public func getCurrentUser() -> User? {
        return currentUser
    }
    
    public func logUserIn(user: User) {
        currentUser = user
    }
    
    public func logUserOut() {
        currentUser = nil
    }
    
    public typealias RegistrationCallback = (Result<User, Error>) -> Void
    
    /**
            Registers a user from AuthCredentials
     */
    public func registerUser(withCredentials credentials: AuthCredentials,
                                    completion: @escaping RegistrationCallback) {
        
        guard let safeProfilePicture = credentials.profilePicutre,
              let safeEmail = credentials.email,
              let safePassword = credentials.password else {
            completion(.failure(RegistrationErrors.credentialIsNil))
            return
            
        }
        
        //Upload the image to the database
        Service.uploadImage(image: safeProfilePicture) { imageUrl in
            
            //Create the user
            Auth.auth().createUser(withEmail: safeEmail, password: safePassword) { [weak self] result, error in
                
                //Check for errors
                guard error == nil else {
                    self?.returnError(error: .failedToCreateUser, completion: completion)
                    return
                }
                
                //Grab user id
                guard let uid = result?.user.uid else {
                    self?.returnError(error: .failedToCreateUid, completion: completion)
                    return
                }
                
                //Create data for user
                guard let user = User(with: credentials,
                                      profileDownloadUrl: [imageUrl],
                                      uid: uid) else {
                    self?.returnError(error: .failedToCreateUser, completion: completion)
                    return
                }
                
                self?.uploadUserToFirestore(for: user, completion: completion)
                
            }
        }
    }
    
    private func uploadUserToFirestore(for user: User,
                                       completion: @escaping RegistrationCallback) {
        
        let userNode = user.getUserNode()
        
        //Grab collection based off of gender
        let collection = user.userSettings.gender == .male ? COLLECTION_MALE_USERS : COLLECTION_FEMALE_USERS
        
        //Set the data
        collection.document(user.uid).setData(userNode) { [weak self] error in
            
            guard error == nil else {
                self?.returnError(error: .failedToUploadToFirestore, completion: completion)
                return
            }
        
            
            self?.updateUserLocation(for: user, completion: completion)
            

            
        }
        
        
    }
    
    public func updateUserLocation(for user: User, completion: @escaping RegistrationCallback) {
        
        //Create geoPoint
        let geoPoint = GeoPoint(latitude: user.userSettings.latitude,
                                longitude: user.userSettings.longitude)
        
        //Get collection based on gender
        let collection = user.userSettings.gender == .male ? COLLECTION_LOCATION_MALE : COLLECTION_LOCATION_FEMALE
        
        
        //Set location
        collection.setLocation(geopoint: geoPoint, forDocumentWithID: user.uid) { [weak self] error in
            
            guard error == nil else {
                self?.returnError(error: .failedToSetLocation, completion: completion)
                return
            }
            
            completion(.success(user))
        }
        

    }
    
    private func returnError(error: RegistrationErrors, completion: RegistrationCallback) {
        completion(.failure(error))
    }
}
    
enum RegistrationErrors: Error {
    case credentialIsNil
    case failedToCreateUid
    case failedToCreateUser
    case failedToSetLocation
    case failedToUploadToFirestore
}

