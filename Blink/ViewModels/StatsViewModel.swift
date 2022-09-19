//
//  StatsViewModel.swift
//  Blink
//
//  Created by Michael Abrams on 9/14/22.
//

import Foundation
import UIKit
import CoreLocation



struct StatViewModel {
    
    private let METERS_TO_MILTES: Double = 1609.344
    
    private let section: StatsTableSection
    
    public var statsIcon: UIImage = #imageLiteral(resourceName: "Phone icon")
    
    public var statsText: NSMutableAttributedString = NSMutableAttributedString(string: "")
    
    public var infoText: String = ""
    
    public var infoIcon: UIImage = #imageLiteral(resourceName: "GPS Icon")
    
    public var aboutMe: String
    
    public var firstName: String
    
    init(section: StatsTableSection, user: User) {

        self.section = section
        self.aboutMe = user.userProfile.bio
        self.firstName = user.userProfile.firstName
        
        switch section {
        case .statSection(let statisticsSection):
            switch statisticsSection {
            case .ghosted:
                statsIcon = #imageLiteral(resourceName: "Ghost icon")
                statsText = NSMutableAttributedString(string: "Ghosted - ", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular), .foregroundColor: #colorLiteral(red: 0.4078431373, green: 0.4078431373, blue: 0.4078431373, alpha: 1)])
                statsText.append(NSAttributedString(string: "\(user.userStats.ghosted) people", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .light), .foregroundColor: #colorLiteral(red: 0.5529411765, green: 0.5333333333, blue: 0.5333333333, alpha: 1)]))
            case .talkingTo:
                statsIcon = #imageLiteral(resourceName: "Phone icon")
                statsText = NSMutableAttributedString(string: "Talking To - ", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular), .foregroundColor: #colorLiteral(red: 0.4078431373, green: 0.4078431373, blue: 0.4078431373, alpha: 1)])
                statsText.append(NSAttributedString(string: "\(user.userStats.conversations) people", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .light), .foregroundColor: #colorLiteral(red: 0.5529411765, green: 0.5333333333, blue: 0.5333333333, alpha: 1)]))
            case .swipeRight:
                statsIcon = #imageLiteral(resourceName: "Thumbs Up Icon")
                let statsFact = user.userStats.swipedRightPercentage == 0 ? "N/A" : String(format: "%.1f", user.userStats.swipedRightPercentage, "% of swipes")
                statsText = NSMutableAttributedString(string: "Swipes Right - ", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular), .foregroundColor: #colorLiteral(red: 0.4078431373, green: 0.4078431373, blue: 0.4078431373, alpha: 1)])
                statsText.append(NSAttributedString(string: "\(statsFact)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .light), .foregroundColor: #colorLiteral(red: 0.5529411765, green: 0.5333333333, blue: 0.5333333333, alpha: 1)]))
            case .swipeLeft:
                statsIcon = #imageLiteral(resourceName: "Thumbs Down icon")
                let statsFact = user.userStats.swipedLeftPercentage == 0 ? "N/A" : String(format: "%.1f", user.userStats.swipedLeftPercentage, "% of swipes")
                statsText = NSMutableAttributedString(string: "Swipes Left - ", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular), .foregroundColor: #colorLiteral(red: 0.4078431373, green: 0.4078431373, blue: 0.4078431373, alpha: 1)])
                statsText.append(NSAttributedString(string: "\(statsFact)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .light), .foregroundColor: #colorLiteral(red: 0.5529411765, green: 0.5333333333, blue: 0.5333333333, alpha: 1)]))
            }
        case .aboutSection(_): break
        case .infoSection(let infoSection):
            switch infoSection {
            case .occupation:
                infoIcon = #imageLiteral(resourceName: "Job Icon")
                infoText = user.userProfile.occupation == "" ? "N/A" : user.userProfile.occupation
            case .gender:
                infoIcon = #imageLiteral(resourceName: "Person Icon")
                infoText = user.userSettings.gender.rawValue.capitalizingFirstLetter()
            case .distance:
                infoIcon = #imageLiteral(resourceName: "GPS Icon")
                infoText = "\(getDistance(otherUser: user)) miles away"
            case .school:
                infoIcon = #imageLiteral(resourceName: "School Icon")
                infoText = user.userProfile.school == "" ? "N/A" : user.userProfile.school
            }
        case .reportSection(_): break
        }
        
        
    }
    
    private func getDistance(otherUser: User) -> Int {
        
        guard let currentUser = RegistrationManager.shared.getCurrentUser() else { return 0 }
        
        let coordinateOne = CLLocation(latitude: currentUser.userSettings.latitude,
                                       longitude: currentUser.userSettings.longitude)
        
        let coordinateTwo = CLLocation(latitude: otherUser.userSettings.latitude,
                                       longitude: otherUser.userSettings.longitude)
        
        return Int(coordinateOne.distance(from: coordinateTwo) / METERS_TO_MILTES)
        
    }
    
}

enum StatisticsSection: Int {
    case ghosted
    case talkingTo
    case swipeRight
    case swipeLeft
    
    var identifier: String {
        return StatsTableViewCell.identifier
    }
    
    var cellHeight: CGFloat {
        return 50
    }
    
    var headerTitle: String {
        return "Stats"
    }
}

enum AboutSection: Int {
    
    case aboutMe
    
    var identifier: String {
        return AboutMeTableViewCell.identifier
    }
    
    var cellHeight: CGFloat {
        return 30
    }
    
    var headerTitle: String {
        return "About Me"
    }
    
}

enum InfoSection: Int {
    case occupation
    case gender
    case distance
    case school
    
    var identifier: String {
        return InfoTableViewCell.identifier
    }
    
    var cellHeight: CGFloat {
        return 50
    }
    
    var headerTitle: String {
        return "Info"
    }
}

enum ReportSection: Int {
    case report
    
    var identifier: String {
        return ReportTableViewCell.identifier
    }
    
    var cellHeight: CGFloat {
        return 70
    }
    
    var headerTitle: String {
        return ""
    }
}

enum StatsTableSection {
    case statSection(StatisticsSection)
    case aboutSection(AboutSection)
    case infoSection(InfoSection)
    case reportSection(ReportSection)
    
    public var heightForFooter: CGFloat {
        switch self {
        case .reportSection(_):
            return 2
        default:
            return 10
        }
    }
    
    public var identifier: String {
        switch self {
        case .statSection(let statisticsSection):
            return statisticsSection.identifier
        case .aboutSection(let aboutMeSection):
            return aboutMeSection.identifier
        case .infoSection(let infoSection):
            return infoSection.identifier
        case .reportSection(let reportSection):
            return reportSection.identifier
        }
    }
    
    public var cellHeight: CGFloat {
        switch self {
        case .statSection(let statisticsSection):
            return statisticsSection.cellHeight
        case .aboutSection(let aboutMeSection):
            return aboutMeSection.cellHeight
        case .infoSection(let infoSection):
            return infoSection.cellHeight
        case .reportSection(let reportSection):
            return reportSection.cellHeight
        }
    }
    
    public var heightForHeader: CGFloat {
        switch self {
        case .reportSection(_):
            return 0
        default:
            return 40
        }
    }
    
    public var headerTitle: String {
        switch self {
        case .statSection(let statisticsSection):
            return statisticsSection.headerTitle
        case .aboutSection(let aboutMeSection):
            return aboutMeSection.headerTitle
        case .infoSection(let infoSection):
            return infoSection.headerTitle
        case .reportSection(let reportSection):
            return reportSection.headerTitle
        }
    }
}
