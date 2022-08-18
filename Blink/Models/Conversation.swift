//
//  Conversation.swift
//  Blink
//
//  Created by Michael Abrams on 8/18/22.
//

import Foundation

public typealias ConversationDictionary = [String: Any]

struct Conversation {
    let fullName: String
    let latestMessage: String
    let profileImageUrl: String
    let uid: String
    
    init(conversationDictionary: ConversationDictionary) {
        self.fullName = conversationDictionary[FULL_NAME] as? String ?? ""
        self.latestMessage = conversationDictionary[LATEST_MESSAGE] as? String ?? ""
        self.profileImageUrl = conversationDictionary[PROFILE_PICTURES] as? String ?? ""
        self.uid = conversationDictionary[UID] as? String ?? ""
    }
    
    init(fullName: String, latestMessage: String, profileImageUrl: String, uid: String) {
        self.fullName = fullName
        self.latestMessage = latestMessage
        self.profileImageUrl = profileImageUrl
        self.uid = uid
    }
    
    public func getConversationNode() -> ConversationDictionary {
        
        let conversationNode: [String: Any] = [
            FULL_NAME: self.fullName,
            LATEST_MESSAGE: self.latestMessage,
            PROFILE_PICTURES: self.profileImageUrl,
            UID: self.uid,
        ]
        
        return conversationNode
        
    }
}
