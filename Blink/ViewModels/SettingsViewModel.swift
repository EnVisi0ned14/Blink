//
//  SettingsViewModel.swift
//  Blink
//
//  Created by Michael Abrams on 8/2/22.
//

import UIKit

enum SettingsSection {
    case logoutSection(LogoutSection)
    case accountSection(AccountSettingsSection)
    
    var identifier: String {
        switch self {
        case .accountSection(let accountSection):
            return accountSection.identifier
        case .logoutSection(let logoutSection):
            return logoutSection.identifier
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .accountSection(let accountSection):
            return accountSection.cellHeight
        case .logoutSection(let logoutSection):
            return logoutSection.cellHeight
        }
    }
    
    var titleForSection: String {
        switch self {
        case .accountSection(let accountSection):
            return accountSection.titleForSection
        case .logoutSection(let logoutSection):
            return logoutSection.titleForSection
        }
    }
    
    var heightForHeader: CGFloat {
        switch self {
        case .accountSection(let accountSection):
            return accountSection.heightForHeader
        case .logoutSection(let logoutSection):
            return logoutSection.heightForHeader
        }
    }
    
}



enum LogoutSection {
    
    case logout
    
    var heightForHeader: CGFloat {
        return 50
    }
    
    var cellHeight: CGFloat {
        return 50
    }
    
    var identifier: String {
        return LogoutTableViewCell.identifier
    }
    
    var titleForSection: String {
        return ""
    }
    
}

enum AccountSettingsSection: Int {
    
    case distance
    case age
    case genderPreference
    case genderSelection
    
    var titleForSection: String {
        return "Account Settings"
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .distance: return 110
        case .age: return 110
        case .genderPreference: return 50
        case .genderSelection: return 50
        }
    }
    
    var cellLabel: String {
        switch self {
        case .distance: return "Distance Preference"
        case .age: return "Age Preference"
        case .genderPreference: return "Show Me"
        case .genderSelection: return "I Am A"
        }
    }
    
    var identifier: String {
        switch self {
        case .distance: return SettingsSliderTableViewCell.identifier
        case .age: return SettingsSliderTableViewCell.identifier
        case .genderSelection: return SettingsGenderTableViewCell.identifier
        case .genderPreference: return SettingsGenderTableViewCell.identifier
        }
    }
    
    var heightForHeader: CGFloat {
        return 30
    }
}



struct SettingsViewModel {
    
    public let section: AccountSettingsSection
    
    public let user: User!
    
    var cellLabel: String {
        return section.cellLabel
    }
    
    var minSliderValue: CGFloat {
        
        if(section == .distance) {
            return 0
        }
        
        if(section == .age) {
            return 18
        }
        
        return 0

    }
    
    var maxSliderValue: CGFloat {
        
        if(section == .distance) {
            return CGFloat(MAX_DISTANCE_RANGE)
        }
        
        if(section == .age) {
            return 60
        }
        
        return 0
        
    }
    
    
    var upperSliderValue: CGFloat {
        
        if(section == .distance) {
            return CGFloat(user.userSettings.distanceRange)
        }
        
        if(section == .age) {
            return CGFloat(user.userSettings.maxSeekingAge)
        }
        
        return 0
    }
    
    var lowerSliderValue: CGFloat {
        
        if(section == .age) {
            return CGFloat(user.userSettings.minSeekingAge)
        }
        
        return 0
    }
    
    var showMeText: String {
        return user.userSettings.preference == .male ? "Men" : "Woman"
    }
    
    var genderText: String {
        return user.userSettings.gender == .male ? "Male" : "Female"
    }
    
    var ageLabelText: String {
        return "\(user.userSettings.minSeekingAge)-\(user.userSettings.maxSeekingAge) yr"
    }
    
    var distanceLabelText: String {
        return "\(user.userSettings.distanceRange) mi"
    }
    
    var shouldEnableDoubleSlider: Bool {
        return section == .age
    }
    
    init(section: AccountSettingsSection, user: User) {
        
        self.section = section
        self.user = user
        
        
        
    }

    
    
    
}



