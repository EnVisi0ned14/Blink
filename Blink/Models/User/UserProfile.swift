//
//  UserProfile.swift
//  Blink
//
//  Created by Michael Abrams on 8/10/22.
//

import Foundation

public struct UserProfile: Codable {
    
    var occupation: String
    var school: String
    var firstName: String
    var lastName: String
    var bio: String
    var birthdayString: String
    var profilePictures: [String]
    
    var fullName: String {
        get { return "\(firstName) \(lastName)"}
    }
    
    var pictureCount: Int {
        return profilePictures.filter({!$0.isEmpty}).count
    }
    
    var age: Int {
        
        //Get birthday String from user
        let birthday = DateManager.getDateFromString(from: birthdayString) ?? Date()
        
        //Return the age
        return Date.getAgeFromDate(for: birthday) ?? 0
        
    }
    
    init(birthdayString: String, profilePictures: [String], firstName: String, lastName: String,
         occupation: String, school: String, bio: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthdayString = birthdayString
        self.profilePictures = profilePictures
        self.occupation = occupation
        self.school = school
        self.bio = bio
    }
    
    enum CodingKeys: String, CodingKey {
        case occupation = "ocupation"
        case school = "school"
        case firstName = "first_name"
        case lastName = "last_name"
        case bio = "bio"
        case birthdayString = "birthday"
        case profilePictures = "profile_pictures"
    }
    
}
