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
    case ageRange
    
    var description: String {
        switch self {
        case .name: return "Name"
        case .profession: return "Profession"
        case .age: return "Age"
        case .bio: return "Bio"
        case .ageRange: return "Seeking Age Range"
        }
    }
}

struct ProfileViewModel {
    
    //private let user: User
    let section: ProfileSection
    
    let placeHolderText: String
    var value: String?
    
    
    
    init(section: ProfileSection) {
        //self.user = user
        self.section = section
        
        placeHolderText = "Enter \(section.description.lowercased()).."
        
//        switch section {
//        
//        case .name:
//            value = user.name
//        case .profession:
//            value = user.profession
//        case .age:
//            value = "\(user.age)"
//        case .bio:
//            value = user.bio
//        }
    }

}
