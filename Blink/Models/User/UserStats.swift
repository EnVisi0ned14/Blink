//
//  UserStats.swift
//  Blink
//
//  Created by Michael Abrams on 8/29/22.
//

import Foundation


public struct UserStats: Codable {
    
    let matches: Int
    let conversations: Int
    let ghosted: Int
    let swipedRightOn: Int
    let swipedLeftOn: Int
    let swipedRight: Int
    let swipedLeft: Int
    
    /** newUser is a pre-built struct with default property for users when they create an account */
    static let newUser: UserStats = UserStats()
    
    var numberOfTimesSwipedOn: Int {
        return swipedLeftOn + swipedRightOn
    }
    
    var numberOfTimesSwiped: Int {
        return swipedLeft + swipedRight
    }
    
    var swipedRightOnPercentage: Double {
        return swipedRightOn == 0 ? 0.0 : Double(numberOfTimesSwipedOn) / Double(swipedRightOn)
    }
    
    var swipedLeftOnPercentage: Double {
        return swipedLeftOn == 0 ? 0.0 : Double(numberOfTimesSwipedOn) / Double(swipedLeftOn)
    }
    
    var swipedRightPercentage: Double {
        return swipedRight == 0 ? 0.0 : Double(numberOfTimesSwiped) / Double(swipedRight)
    }
    
    var swipedLeftPercentage: Double {
        return swipedLeft == 0 ? 0.0 : Double(numberOfTimesSwiped) / Double(swipedLeft)
    }
    
    /**
        Creates User Stats all initalized to default values
     */
    init() {
        self.matches = 0
        self.conversations = 0
        self.ghosted = 0
        self.swipedLeftOn = 0
        self.swipedRightOn = 0
        self.swipedLeft = 0
        self.swipedRight = 0
    }
    
    enum CodingKeys: String, CodingKey {
        
        case matches = "matches"
        case conversations = "conversations"
        case ghosted = "ghosted"
        case swipedRightOn = "swiped_right_on"
        case swipedLeftOn = "swiped_left_on"
        case swipedRight = "swiped_right"
        case swipedLeft = "swiped_left"
        
    }
    


    
    

    
}
