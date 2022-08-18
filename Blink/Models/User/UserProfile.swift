//
//  UserProfile.swift
//  Blink
//
//  Created by Michael Abrams on 8/10/22.
//

import Foundation

public struct UserProfile {
    
    var occupation: String
    var school: String
    var firstName: String
    var lastName: String
    var bio: String
    var birthday: Date
    var profilePictures: [String]
    
    var fullName: String {
        get { return "\(firstName) \(lastName)"}
    }
    
    var age: Int? {
        return Date.getAgeFromDate(for: birthday)
    }
    
    init(birthday: Date, profilePictures: [String], firstName: String, lastName: String,
         occupation: String, school: String, bio: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthday = birthday
        self.profilePictures = profilePictures
        self.occupation = occupation
        self.school = school
        self.bio = bio
    }
    
    init?(userNode: [String: Any]) {
        
        guard let userProfile = userNode[USER_PROFILE] as? [String: Any],
              let firstName = userProfile[FIRST_NAME] as? String,
              let lastName = userProfile[LAST_NAME] as? String,
              let birthdayString = userProfile[BIRTHDAY] as? String,
              let birthdayDate = DateManager.getDateFromString(from: birthdayString),
              let ocupation = userProfile[OCUPATION] as? String,
              let bio = userProfile[BIO] as? String,
              let profilePictures = userProfile[PROFILE_PICTURES] as? [String],
              let school = userProfile[SCHOOL] as? String else { return nil }
        
        self.occupation = ocupation
        self.firstName = firstName
        self.lastName = lastName
        self.birthday = birthdayDate
        self.bio = bio
        self.school = school
        self.profilePictures = profilePictures

    }
    
}