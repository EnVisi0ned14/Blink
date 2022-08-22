//
//  ConversationTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 8/18/22.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
    
    //MARK: - Fields
    
    public static let identifier = "ConversationTableViewCell"
    
    private let CORNER_RADIUS: CGFloat = 50
    
    private let HEIGHT: CGFloat = 120
    
    private let profileIcon = ProfileIcon(width: 80, height: 80)
    
    private let nameLabel = CustomLabel(size: 30, weight: .regular, textColor: .black)
    
    private let latestMessageLabel = CustomLabel(size: 20, weight: .regular, textColor: #colorLiteral(red: 0.4078431373, green: 0.4078431373, blue: 0.4078431373, alpha: 1))
    
    var conversation: Conversation! {
        didSet { configureCell() }
    }
    

    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = CGRect(x: 0, y: 0,
                                   width: frame.width - 20,
                                   height: frame.height - 20)
        
    }
    
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        //Set background color
        backgroundColor = .white
        
        //Remove highlight when selected
        selectionStyle = .none
        
        //Add subviews
        [profileIcon, nameLabel, latestMessageLabel].forEach({contentView.addSubview($0)})
        
        //Configure profile icon
        profileIcon.anchor(top: contentView.topAnchor, left: contentView.leadingAnchor, paddingTop: 10, paddingLeft: 15)
        
        //Clips to bounds -> true
        contentView.clipsToBounds = true
        
        //Set corner radius
        contentView.layer.cornerRadius = CORNER_RADIUS
        
        //Set background color
        contentView.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.8705882353, blue: 0.7450980392, alpha: 1)
        
        //Configure name label
        nameLabel.anchor(top: contentView.topAnchor, left: profileIcon.trailingAnchor, paddingTop: 10, paddingLeft: 10)
        
        //Configure latest message label
        latestMessageLabel.anchor(top: nameLabel.bottomAnchor, left: profileIcon.trailingAnchor, paddingTop: 5, paddingLeft: 10)
        
        
    }
    
    private func configureCell() {
        
        print("DEBUG: Configuring for \(conversation.profileImageUrl)")
        print("DEBUG: Conversation name: \(conversation.firstName)")
        
        guard let profileURL = URL(string: conversation.profileImageUrl) else { return }

        //Set profile URL
        profileIcon.setProfilePicture(with: profileURL)
        
        //Set name label
        nameLabel.text = conversation.firstName
        
        //Set latest message label
        latestMessageLabel.text = conversation.latestMessage

    }
    
    
}
