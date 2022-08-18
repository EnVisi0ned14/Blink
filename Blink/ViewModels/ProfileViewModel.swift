//
//  ProfileViewModel.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

enum ProfileSection: Int, CaseIterable {
    
    case name
    case bio
    case school
    case profession
    
    var description: String {
        switch self {
        case .name: return "Name"
        case .bio: return "Bio"
        case .profession: return "Occupation"
        case .school: return "School"
        
        }
    }
}

struct ProfileViewModel {
    
    public let user: User
    
    let section: ProfileSection
    
    let placeHolderText: String
    var value: String?
    
    init(section: ProfileSection, user: User) {
        //self.user = user
        self.section = section
        self.user = user

        placeHolderText = "Enter \(section.description.lowercased()).."
        
        switch section {
        
        case .name:
            value = user.userProfile.fullName
        case .profession:
            value = user.userProfile.occupation
        case .school:
            value = user.userProfile.school
        case .bio:
            value = user.userProfile.bio
        }
    }

}
