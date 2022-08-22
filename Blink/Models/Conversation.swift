//
//  Conversation.swift
//  Blink
//
//  Created by Michael Abrams on 8/18/22.
//

import Foundation

public typealias ConversationDictionary = [String: Any]

public struct Conversation {
    
    
    let firstName: String
    let latestMessage: String
    let profileImageUrl: String
    let uid: String
    let conversationId: String
    
    init(conversationDictionary: ConversationDictionary) {
        self.firstName = conversationDictionary[FIRST_NAME] as? String ?? ""
        self.latestMessage = conversationDictionary[LATEST_MESSAGE] as? String ?? ""
        self.conversationId = conversationDictionary[CONVERSATION_ID] as? String ?? ""
        self.profileImageUrl = conversationDictionary[PROFILE_PICTURES] as? String ?? ""
        self.uid = conversationDictionary[UID] as? String ?? ""
    }
    
    init(firstName: String, latestMessage: String, profileImageUrl: String, uid: String, conversationId: String) {
        
        self.firstName = firstName
        self.conversationId = conversationId
        self.latestMessage = latestMessage
        self.profileImageUrl = profileImageUrl
        self.uid = uid
        
    }
    
    public func getConversationNode() -> ConversationDictionary {
        
        return [FIRST_NAME: self.firstName,
                LATEST_MESSAGE: self.latestMessage,
                PROFILE_PICTURES: self.profileImageUrl,
                UID: self.uid,
                CONVERSATION_ID: self.conversationId
               ]
    }
    
}
