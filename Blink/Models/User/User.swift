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

public enum Gender: String, Codable {
    
    case male = "male"
    case female = "female"
    
}

public class User: Codable {
    
    //MARK: - Fields

    var email: String
    var userSettings: UserSettings
    var userProfile: UserProfile
    var userStats: UserStats
    var uid: String
    
    var preferenceCollection: CollectionReference {
        switch userSettings.preference {
        case .male:
            return COLLECTION_MALE_USERS
        case .female:
            return COLLECTION_FEMALE_USERS
        }
    }
    var genderCollection: CollectionReference {
        switch userSettings.gender {
        case .male:
            return COLLECTION_MALE_USERS
        case .female:
            return COLLECTION_FEMALE_USERS
        }
    }
    
    var locationCollection: GeoFirestore {
        switch userSettings.preference {
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
    
    init(email: String, uid: String, userSettings: UserSettings,
         userProfile: UserProfile, userStats: UserStats) {
        
        self.email = email
        self.uid = uid
        self.userSettings = userSettings
        self.userProfile = userProfile
        self.userStats = userStats

    }
    

    //MARK: - Helpers
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case uid = "uid"
        case userProfile = "user_profile"
        case userSettings = "user_settings"
        case userStats = "user_stats"
    }
    

    public func createConversationNode(for user: User,
                                       message: Message,
                                       id: String) -> [String: Any] {
        
        let conversationNode: [String: Any] = [
            
            LATEST_MESSAGE: message.textMessage,
            CONVERSATION_ID: id,
            FIRST_NAME: user.userProfile.firstName,
            UID: user.uid,
            PROFILE_PICTURES: user.userProfile.profilePictures[0]
        ]

        return conversationNode
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
        private var birthdayString: String = DateManager.getDateString(from: Date())
        private var profilePictures: [String] = ["", "", "", "", "", ""]
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

        public func setBirthday(birthdayString: String) -> UserBuilder {
            self.birthdayString = birthdayString
            return self
        }
        
        public func setProfilePictures(profilePictures: [String]) -> UserBuilder {
            
            for (index, profilePicture) in profilePictures.enumerated() {
                self.profilePictures[index] = profilePicture
            }
            
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
            
            let userProfile = UserProfile(birthdayString: birthdayString, profilePictures: profilePictures,
                                          firstName: firstName, lastName: lastName,
                                          occupation: occupation, school: school, bio: bio)
            
            let userSettings = UserSettings(minSeekingAge: minSeekingAge, maxSeekingAge: maxSeekingAge,
                                            distanceRange: distanceRange, gender: gender,
                                            preference: preference, geoHash: geoHash,
                                            latitude: latitude, longitude: longitude)
            
            
            return User(email: email, uid: uid, userSettings: userSettings, userProfile: userProfile, userStats: UserStats.newUser)
            
        }
        
    }
    
    
}
