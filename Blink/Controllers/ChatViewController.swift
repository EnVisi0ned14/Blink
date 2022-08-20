//
//  ChatViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/20/22.
//

import UIKit
import MessageKit

public class ChatViewController: MessagesViewController {
    
    //MARK: - Fields
    
    private let user: User
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
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
        
        //Configure the UI
        configureUI()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Hide the tab bar
        tabBarController?.tabBar.isHidden = true
        
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        //Set the title for the view controller
        title = user.userProfile.firstName
        
        
        
    }
    
}

//MARK: - Message Data Source

extension ChatViewController: MessagesDataSource {
    
    public func currentSender() -> SenderType {
        <#code#>
    }
    
    public func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        <#code#>
    }
    
    public func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        <#code#>
    }
    
    
}

//MARK: - Messages Layout Delegate
extension ChatViewController: MessagesLayoutDelegate {
    
}

//MARK: - Messages Display Delegate

extension ChatViewController: MessagesDisplayDelegate {
    
}
