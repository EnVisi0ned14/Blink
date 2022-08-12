//
//  ProfileViewModel.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

enum ProfileSection: Int, CaseIterable {
    
    case name
    case profession
    case age
    case bio
    
    var description: String {
        switch self {
        case .name: return "Name"
        case .profession: return "Profession"
        case .age: return "Age"
        case .bio: return "Bio"
        }
    }
}

struct ProfileViewModel {
    
    private let user: User
    
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
        case .age:
            value = "\(user.userProfile.age ?? 0)"
        case .bio:
            value = user.userProfile.bio
        }
    }

}
