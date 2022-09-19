//
//  ChatViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/20/22.
//

import UIKit
import MessageKit
import InputBarAccessoryView


public class ChatViewController: AbstractChatViewController {
    
    
    //MARK: - Lifecycle
    
    init(sender: User, reciever: User) {
        super.init(conversationId: UUID().uuidString, sender: sender, reciever: reciever)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Actions
    
    override public func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        //Create message
        let message = createMessage(with: text)
        
        //If this is the first message ever sent
        if(messages.count == 0) {
            
            //Create conversation
            Service.createConversation(sendTo: reciever, from: sender, message: message, id: conversationId) { [weak self] in
                
                //Start observing the conversation
                self?.observeConversation(for: self?.conversationId ?? "")

            }
        }
        else {
            Service.sendMessage(to: conversationId, message: message)
        }
        
        
        //Clear text in inputbar
        inputBar.inputTextView.text = ""
        
    }
    
}


