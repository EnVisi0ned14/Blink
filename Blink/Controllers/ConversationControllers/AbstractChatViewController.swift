//
//  AbstractChatViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/22/22.
//

import Foundation
import MessageKit
import InputBarAccessoryView
import UIKit

public class AbstractChatViewController: MessagesViewController, InputBarAccessoryViewDelegate {
    
    
    //MARK: - Fields
    
    internal let sender: User
    internal let reciever: User
    internal let conversationId: String
    
    internal var messages: [MessageType] = [MessageType]() {
        didSet { messagesCollectionView.reloadData() }
    }
    
    //MARK: - Lifecycle

    init(conversationId: String, sender: User, reciever: User) {
        self.sender = sender
        self.reciever = reciever
        self.conversationId = conversationId
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
        
        //Configure messages collection view
        configureMessageCollectionView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Show navigation controller
        navigationController?.navigationBar.isHidden = false
        
        //Hide the tab bar
        tabBarController?.tabBar.isHidden = true
        
    }
    
    //MARK: - Actions
    
    public func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        fatalError("Input Bar did press send button not implemented")
    }
    
    //MARK: - Helpers
    
    internal func observeConversation(for conversationId: String) {

        Service.loadConversation(from: conversationId) { messages in
            self.messages = messages
        }
        
    }
    
    internal func createMessage(with text: String) -> Message {
        return Message(sender: currentSender() as! Sender, kind: MessageKind.text(text), messageId: UUID().uuidString, sentDate: Date())
    }
    
    private func configureUI() {
        
        //Set the title to recieving user
        navigationItem.title = reciever.userProfile.firstName

    }
    
    private func configureMessageCollectionView() {
        //Scroll to last item when -> editing
        scrollsToLastItemOnKeyboardBeginsEditing = true
        //Maintain height
        maintainPositionOnKeyboardFrameChanged = true
        //Show time stamp
        showMessageTimestampOnSwipeLeft = true
        
        //Remove the avatars
        removeAvatars()
    }
    
    private func removeAvatars() {
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
        layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
        layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
        
    }
    
    
    
    
}

//MARK: - Message Data Source


extension AbstractChatViewController: MessagesDataSource {
    
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
extension AbstractChatViewController: MessagesLayoutDelegate {
    
    public func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
        avatarView.frame = .zero
        
    }
    
    

    
    public func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        let backGroundTextColor: UIColor
        
        //If sender return orange else return light grey
        backGroundTextColor = message.sender.senderId == sender.uid ? #colorLiteral(red: 0.9960784314, green: 0.8470588235, blue: 0.6941176471, alpha: 1) : #colorLiteral(red: 0.8891186118, green: 0.9215199351, blue: 0.957315743, alpha: 1)
        
        return backGroundTextColor
        
    }
    
    public func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        let textColor: UIColor
        
        //If sender return orange else return light grey
        textColor = message.sender.senderId == sender.uid ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        return textColor
        
    }
    
    
    
}

//MARK: - Messages Display Delegate

extension AbstractChatViewController: MessagesDisplayDelegate {
    
}


