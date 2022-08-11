//
//  SettingsViewModel.swift
//  Blink
//
//  Created by Michael Abrams on 8/2/22.
//

import UIKit

enum SettingSection: Int, CaseIterable {
    
    case distance
    case age
    case genderPreference
    case genderSelection
    
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
    
    
    
}

struct SettingsViewModel {
    
    public let section: SettingSection
    
    private let user: User!
    
    var cellLabel: String {
        return section.cellLabel
    }
    
    var minSliderValue: CGFloat {
        
        if(section == .distance) {
            return CGFloat(user.userSettings.distanceRange)
        }
        
        if(section == .age) {
            return CGFloat(user.userSettings.minSeekingAge)
        }
        
        return 0

    }
    
    var maxSliderValue: CGFloat {
        
        if(section == .distance) {
            return CGFloat(user.userSettings.distanceRange)
        }
        
        if(section == .age) {
            return CGFloat(user.userSettings.maxSeekingAge)
        }
        
        return 0
        
    }
    
    var minDistanceSliderValue: CGFloat {
        return 0
    }
    
    var maxDistanceSliderValue: CGFloat {
        return 50
    }
    
    var showMeText: String {
        return user.userSettings.preference == .male ? "Men" : "Woman"
    }
    
    var genderText: String {
        return user.userSettings.gender == .male ? "Male" : "Female"
    }
    
    func ageLabelText(forMin min: Int, forMax max: Int) -> String {
        return "\(Int(min))-\(Int(max)) yr"
    }
    
    func distanceLabelText(forValue value: Int) -> String {
        return "\(value) mi"
    }
    
    init(section: SettingSection, user: User) {
        
        self.section = section
        self.user = user
        
        
        
    }

    
    
    
}



