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
        
        //Update current user
        currentUser = user
        
        //Notify observers that user logged in
        NotificationCenter.default.post(name: Notification.Name(rawValue: USER_LOGGED_IN),
                                        object: nil)
    }
    
    public func logUserOut() {
        
        //Log user out
        currentUser = nil
        
        //Notify observers that user logged out
        NotificationCenter.default.post(name: Notification.Name(USER_LOGGED_OUT),
                                        object: nil)
    }
    
    public typealias RegistrationCallback = (Result<User, Error>) -> Void
    
    /**
            Registers a user from AuthCredentials
     */
    public func registerUser(withCredentials credentials: AuthCredentials,
                                    completion: @escaping RegistrationCallback) {
        
        
        //Upload the image to the database
        Service.uploadImage(image: credentials.profilePicutre) { imageUrl in
            
            //Create the user
            Auth.auth().createUser(withEmail: credentials.email,
                                   password: credentials.password) { [weak self] result, error in
                
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

                //Create user builder
                let userBuilder = User.UserBuilder()
                    .setUid(uid: uid)
                    .setEmail(email: credentials.email)
                    .setGender(gender: credentials.gender)
                    .setPreference(preference: credentials.preference)
                    .setBirthday(birthdayString: credentials.birthday)
                    .setFirstName(firstName: credentials.firstName)
                    .setLastName(lastName: credentials.lastName)
                    .setProfilePictures(profilePictures: [imageUrl])
                    .setGeoHash(geoHash: credentials.location.geoHash)
                    .setLatitude(latitude: credentials.location.latitude)
                    .setLongitude(longitude: credentials.location.longitude)

                //Upload user to firestore
                self?.uploadUserToFirestore(for: userBuilder.build(), completion: completion)
                
            }
        }
    }
    
    private func uploadUserToFirestore(for user: User,
                                       completion: @escaping RegistrationCallback) {
        
        
        //Grab collection based off of gender
        let collection = user.userSettings.gender == .male ? COLLECTION_MALE_USERS : COLLECTION_FEMALE_USERS
        
        //Set the data
        do {
            try collection.document(user.uid).setData(from: user, merge: true)
            
            updateUserLocation(for: user, completion: completion)
            
        }
        catch (let error) {
            print("Error setting the user data: \(error.localizedDescription)")
            returnError(error: .failedToUploadToFirestore, completion: completion)
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

