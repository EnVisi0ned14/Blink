//
//  Message.swift
//  Blink
//
//  Created by Michael Abrams on 8/20/22.
//

import Foundation
import MessageKit
import FirebaseFirestoreSwift




public struct Message: MessageType {
    
    public var sender: SenderType
    
    public var messageId: String
    
    public var sentDate: Date
    
    public var kind: MessageKind
    
    public var textMessage: String {
        switch kind {

        case .text(let textMessage):
            return textMessage
        case .attributedText(_):
            return ""
        case .photo(_):
            return ""
        case .video(_):
            return ""
        case .location(_):
            return ""
        case .emoji(_):
            return ""
        case .audio(_):
            return ""
        case .contact(_):
            return ""
        case .linkPreview(_):
            return ""
        case .custom(_):
            return ""
        }

    }
    
    public var messageKindRawValue: String {
        switch kind {

        case .text(_):
            return "text"
        case .attributedText(_):
            return "attributed_text"
        case .photo(_):
            return "photo"
        case .video(_):
            return "video"
        case .location(_):
            return "location"
        case .emoji(_):
            return "emoji"
        case .audio(_):
            return "audio"
        case .contact(_):
            return "contact"
        case .linkPreview(_):
            return "link_preview"
        case .custom(_):
            return "custom"
        }

    }
    
    init(with messageNode: [String: Any]) {
        
        self.sender = Sender(senderId: messageNode[SENDER_UID] as? String ?? "",
                             displayName: messageNode[SENDER_NAME] as? String ?? "")
        self.kind = .text(messageNode[TEXT_MESSAGE] as? String ?? "")
        self.messageId = messageNode[CONVERSATION_ID] as? String ?? ""
        self.sentDate = DateManager.getDateFromString(from: messageNode[DATE] as? String ?? "") ?? Date()
    }
    
    init(sender: SenderType, kind: MessageKind, messageId: String, sentDate: Date) {
        self.sender = sender
        self.kind = kind
        self.messageId = messageId
        self.sentDate = sentDate
    }
    
    public func createMessageNode(from conversationId: String) -> [String: Any] {
        
        let messageNode = [
                TEXT_MESSAGE: textMessage,
                DATE: DateManager.getDateString(from: sentDate),
                CONVERSATION_ID: conversationId,
                SENDER_UID: sender.senderId,
                TYPE: messageKindRawValue,
                SENDER_NAME: sender.displayName,
                MESSAGE_ID: messageId
            ]

        return messageNode
        
    }
}
