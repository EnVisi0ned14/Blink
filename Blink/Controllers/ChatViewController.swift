//
//  ChatViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/20/22.
//

import UIKit
import MessageKit
import InputBarAccessoryView


public class ChatViewController: MessagesViewController {
    
    //MARK: - Fields
    
    private let recieveUser: User
    private let sender: User
    
    private var conversationId: String?
    
    private var messages: [MessageType] = [MessageType]() {
        didSet { messagesCollectionView.reloadData() }
    }
    
    //MARK: - Lifecycle
    
    init?(recieveUser: User) {
        
        //Grab current user from registration manager
        guard let currentUser = RegistrationManager.shared.getCurrentUser() else { return nil }
        
        //Assign global properties
        self.recieveUser = recieveUser
        self.sender = currentUser
        
        //Call super init
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle delegates
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        //Configure the UI
        configureUI()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Hide the tab bar
        tabBarController?.tabBar.isHidden = true
        
    }
    
    //MARK: - Actions
    
    
    
    
    //MARK: - Helpers
    
    private func observeConversation() {
        
        guard let conversationId = conversationId else { return }
        
        Service.loadConversation(from: conversationId) { messages in
            self.messages = messages
        }
        
    }
    
    private func createMessage(with text: String) -> Message {
        return Message(sender: currentSender() as! Sender, kind: MessageKind.text(text), messageId: UUID().uuidString, sentDate: Date())
    }
    
    private func configureUI() {
        
        //Set the title to recieving user
        navigationItem.title = recieveUser.userProfile.firstName

    }
    
}

//MARK: - Message Data Source

extension ChatViewController: MessagesDataSource {
    
    public func currentSender() -> SenderType {
        return Sender(senderId: sender.uid, displayName: sender.userProfile.firstName)
    }
    
    public func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    public func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}

//MARK: - Messages Layout Delegate
extension ChatViewController: MessagesLayoutDelegate {
    
}

//MARK: - Messages Display Delegate

extension ChatViewController: MessagesDisplayDelegate {
    
}


//MARK: - InputBarAccessoryViewDelegate
extension ChatViewController: InputBarAccessoryViewDelegate {
    
    public func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        //Create message
        let message = createMessage(with: text)
        
        //If this is the first message ever sent
        if(messages.count == 0) {
            
            //Create conversation
            Service.createConversation(sendTo: recieveUser, from: sender, message: message) { [weak self] conversationId in
                
                //Update the conversation Id
                self?.conversationId = conversationId
                
                //Start observing the conversation
                self?.observeConversation()
                
            }
        }
        else {
            
            guard let conversationId = conversationId else { return }
            
            Service.sendMessage(to: conversationId, message: message)
        }
        
        
        //Clear text in inputbar
        inputBar.inputTextView.text = ""
        

    }
    
}
