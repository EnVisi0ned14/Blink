//
//  MatchesCollectionViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 8/17/22.
//

import UIKit

class MatchesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Fields
    
    public static let identifier = "MatchesCollectionViewCell"
    
    public var match: Match! {
        didSet { configureCell() }
    }
    
    private let profilePicture = MatchProfileCellImageView()
    
    private let nameLabel = CustomLabel(size: 18, weight: .regular, textColor: .black)
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureCell() {
        
        //Add subviews
        [profilePicture, nameLabel].forEach({contentView.addSubview($0)})
        
        //Grab profile url
        guard let profileUrl = URL(string: match.profileImageUrl) else { return }
        
        //Set the image
        profilePicture.setImage(withurl: profileUrl)
        
        //set the name label
        nameLabel.text = match.firstName
        
        //Constrain profile image
        profilePicture.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        
        //Constrain the name label
        nameLabel.anchor(top: profilePicture.bottomAnchor, paddingTop: 5)
        nameLabel.centerX(inView: self)
        
         
        
        
    }
    
}
