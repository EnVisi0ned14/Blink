//
//  User.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit
import FirebaseFirestore
import Geofirestore
import CoreLocation

public enum Gender: String {
    case male = "male"
    case female = "female"
}

public class User {
    
    //MARK: - Fields

    var email: String
    var userSettings: UserSettings
    var userProfile: UserProfile
    var uid: String
    
    var genderedCollection: CollectionReference {
        switch userSettings.gender {
        case .male:
            return COLLECTION_MALE_USERS
        case .female:
            return COLLECTION_FEMALE_USERS
        }
    }
    
    var locationCollection: GeoFirestore {
        switch userSettings.gender {
        case .male:
            return COLLECTION_LOCATION_MALE
        case .female:
            return COLLECTION_LOCATION_FEMALE
        }
    }
    
    var centerLocation: CLLocation {
        return CLLocation(latitude: userSettings.latitude, longitude: userSettings.longitude)
    }
    
    //MARK: - Constructor
    
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
    

    init(email: String, uid: String, userSettings: UserSettings, userProfile: UserProfile) {
        
        self.email = email
        self.uid = uid
        self.userSettings = userSettings
        self.userProfile = userProfile

    }

    //MARK: - Helpers
    
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
            OCUPATION: userProfile.occupation,
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
        
            MAX_SEEKING_AGE_KEY: userSettings.maxSeekingAge,
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
    
    public class UserBuilder {
        
        //User fields
        private var email: String = ""
        private var uid: String = ""
        
        //User settings fields
        private var maxSeekingAge: Int = MAX_AGE
        private var minSeekingAge: Int = MIN_AGE
        private var distanceRange: Int = MAX_DISTANCE_RANGE
        private var gender: Gender = .male
        private var preference: Gender = .male
        private var geoHash: String = ""
        private var latitude: Double = 0
        private var longitude: Double = 0
        
        //User profile
        private var birthday: Date = Date()
        private var profilePictures: [String] = []
        private var firstName: String = ""
        private var lastName: String = ""
        private var occupation: String = ""
        private var bio: String = ""
        private var school: String = ""

        public func setEmail(email: String) -> UserBuilder {
            self.email = email
            return self
        }
        
        public func setUid(uid: String) -> UserBuilder {
            self.uid = uid
            return self
        }
        
        public func setMaxSeekingAge(maxSeekingAge: Int) -> UserBuilder {
            self.maxSeekingAge = maxSeekingAge
            return self
        }
        
        public func setMinSeekingAge(minSeekingAge: Int) -> UserBuilder {
            self.minSeekingAge = minSeekingAge
            return self
        }
        
        public func setDistanceRange(distanceRange: Int) -> UserBuilder {
            self.distanceRange = distanceRange
            return self
        }
        
        public func setGender(gender: Gender) -> UserBuilder {
            self.gender = gender
            return self
        }
        
        public func setPreference(preference: Gender) -> UserBuilder {
            self.preference = preference
            return self
        }
        
        public func setGeoHash(geoHash: String) -> UserBuilder {
            self.geoHash = geoHash
            return self
        }
        
        public func setLongitude(longitude: Double) -> UserBuilder {
            self.longitude = longitude
            return self
        }
        
        public func setLatitude(latitude: Double) -> UserBuilder {
            self.latitude = latitude
            return self
        }

        public func setBirthday(birthday: Date) -> UserBuilder {
            self.birthday = birthday
            return self
        }
        
        public func setProfilePictures(profilePictures: [String]) -> UserBuilder {
            self.profilePictures = profilePictures
            return self
        }
        
        public func setFirstName(firstName: String) -> UserBuilder {
            self.firstName = firstName
            return self
        }
        
        public func setLastName(lastName: String) -> UserBuilder {
            self.lastName = lastName
            return self
        }
        
        public func setOccupation(occupation: String) -> UserBuilder {
            self.occupation = occupation
            return self
        }
        
        public func setSchool(school: String) -> UserBuilder {
            self.school = school
            return self
        }
        
        public func setBio(bio: String) -> UserBuilder {
            self.bio = bio
            return self
        }
        
        public func build() -> User {
            
            let userProfile = UserProfile(birthday: birthday, profilePictures: profilePictures,
                                          firstName: firstName, lastName: lastName,
                                          occupation: occupation, school: school, bio: bio)
            
            let userSettings = UserSettings(minSeekingAge: minSeekingAge, maxSeekingAge: maxSeekingAge,
                                            distanceRange: distanceRange, gender: gender,
                                            preference: preference, geoHash: geoHash,
                                            latitude: latitude, longitude: longitude)
            
            return User(email: email, uid: uid, userSettings: userSettings, userProfile: userProfile)
            
        }
        
    }
    
    
}
