//
//  MatchViewModel.swift
//  Blink
//
//  Created by Michael Abrams on 8/13/22.
//

import Foundation

struct MatchViewModel {
    
    private let currentUser: User
    private let otherUser: User
    
    var currentUserImageUrl: URL?
    var matchedUserImageUrl: URL?
    
    init(currentUser: User, otherUser: User) {
        self.currentUser = currentUser
        self.otherUser = otherUser
        self.currentUserImageUrl = URL(string: currentUser.userProfile.profilePictures[0])
        self.matchedUserImageUrl = URL(string: otherUser.userProfile.profilePictures[0])
    }
}
