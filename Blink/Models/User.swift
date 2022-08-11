//
//  User.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit

enum Gender: String {
    case male = "male"
    case female = "female"
}


public struct User {
    
    //MARK: - Fields

    var email: String
    var userSettings: UserSettings
    var userProfile: UserProfile
    var uid: String
    
    
    init?(with userNode: [String: Any]) {
        
        guard let userProfile = UserProfile(userNode: userNode),
              let userSettings = UserSettings(userNode: userNode),
              let email = userNode[EMAIL] as? String,
              let uid = userNode[UID] as? String else { return nil }
        
        self.userProfile = userProfile
        self.userSettings = userSettings
        self.email = email
        self.uid = uid

    }
    
    /**
        Initalize a new user with credentials. Will initalize user with default settings and profile
     */
    init?(with credentials: AuthCredentials,
          profileDownloadUrl: [String],
          uid: String) {
        
        guard let birthday = credentials.birthday,
              let firstName = credentials.firstName,
              let lastName = credentials.lastName,
              let gender = credentials.gender,
              let preference = credentials.preference,
              let geoHash = credentials.location?.geoHash,
              let latitude = credentials.location?.latitude,
              let longitude = credentials.location?.longitude,
              let email = credentials.email else {
            return nil
        }
        
        //Create default profile
        self.userProfile = UserProfile(birthday: birthday,
                                         profilePictures: profileDownloadUrl,
                                         firstName: firstName,
                                         lastName: lastName)
        //Create default settings
        self.userSettings = UserSettings(minSeekingAge: MAX_AGE,
                                         maxSeekingAge: MIN_AGE,
                                         distanceRange: MAX_DISTANCE_RANGE,
                                         gender: gender,
                                         preference: preference,
                                         geoHash: geoHash,
                                         latitude: latitude,
                                         longitude: longitude)
        
        //Assign email
        self.email = email
        
        //Assign user id
        self.uid = uid

    }

    //Transforms the user into a map ready for firestore
    public func getUserNode() -> [String: Any] {
        
        let userProfile = createProfileNode()
        
        let userSettings = createSettingsNode()
        
        return createUserNode(userProfile, userSettings)
        

        
    }
    
    private func createUserNode(_ userProfile: [String: Any], _ userSettings: [String: Any]) -> [String: Any] {
        
        let userNode: [String: Any] = [
            EMAIL: email,
            UID: uid,
            USER_SETTINGS: userSettings,
            USER_PROFILE: userProfile
        ]
        
        return userNode
        
    }
    
    private func createProfileNode() -> [String: Any] {
        
        let userProfile: [String: Any] = [
        
            BIRTHDAY: DateManager.getDateString(from: userProfile.birthday),
            OCUPATION: userProfile.ocupation,
            SCHOOL: userProfile.school,
            BIO: userProfile.bio,
            FIRST_NAME: userProfile.firstName,
            LAST_NAME: userProfile.lastName,
            PROFILE_PICTURES: userProfile.profilePictures

        ]
        
        return userProfile
    }
    
    private func createSettingsNode() -> [String: Any] {
        
        let settingsNode: [String: Any] = [
        
            MAX_SEEKING_AGE: userSettings.maxSeekingAge,
            MIN_SEEKING_AGE: userSettings.minSeekingAge,
            DISTANCE_RANGE: userSettings.distanceRange,
            GENDER: userSettings.gender.rawValue,
            PREFERENCE: userSettings.preference.rawValue,
            GEO_HASH: userSettings.geoHash,
            LATITUDE: userSettings.latitude,
            LONGITUDE: userSettings.longitude

        ]
        
        return settingsNode
        
    }
    
}
