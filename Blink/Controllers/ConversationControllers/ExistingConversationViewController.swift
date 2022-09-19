//
//  ExistingConversationViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/22/22.
//

import Foundation
import MessageKit
import InputBarAccessoryView

public class ExistingConversationViewController: AbstractChatViewController {

    
    override init(conversationId: String, sender: User, reciever: User) {
        super.init(conversationId: conversationId, sender: sender, reciever: reciever)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        //Observe the conversation / Load Messages
        observeConversation(for: conversationId)
        
    }
    
    public override func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {

        //Send the message to conversation
        Service.sendMessage(to: conversationId, message: createMessage(with: text))
        
        //Clear text in inputbar
        inputBar.inputTextView.text = ""
        
    }
    
}
