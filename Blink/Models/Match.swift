//
//  Match.swift
//  Blink
//
//  Created by Michael Abrams on 8/13/22.
//

import Foundation

public typealias MatchDictionary = [String : Any]

public struct Match {
    
    let firstName: String
    let profileImageUrl: String
    let uid: String
    
    init(with matchDictionary: MatchDictionary) {
        self.firstName = matchDictionary[FIRST_NAME] as? String ?? ""
        self.profileImageUrl = matchDictionary[PROFILE_PICTURES] as? String ?? ""
        self.uid = matchDictionary[UID] as? String ?? ""
    }
    
    init(name: String, profileImageUrl: String, uid: String) {
        self.firstName = name
        self.profileImageUrl = profileImageUrl
        self.uid = uid
    }
    
    public func getMatchNode() -> MatchDictionary {
        return [FIRST_NAME: firstName, PROFILE_PICTURES: profileImageUrl, UID: uid]
    }
}
