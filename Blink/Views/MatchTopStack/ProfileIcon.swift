//
//  ProfileIcon.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit
import SDWebImage

protocol ProfileIconDelegate: AnyObject {
    
    func wantsToDisplayProfileController()
    
}


class ProfileIcon: UIImageView {
    
    //MARK: - Fields
    
    public weak var delegate: ProfileIconDelegate?
    
    //MARK: - Lifecycle
    
    init(width: CGFloat? = nil, height: CGFloat? = nil) {
        super.init(frame: .zero)
        
        //Constrain profileIcon
        configureConstraints(width: width, height: height)
        
        //Sets the image view's fields
        setImageViewFields()
        
        //Set up the tap gesture
        setUpTapGesture()
        
    }
    
    //Required decoder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Set the image view to a circle
        layer.cornerRadius = frame.width / 2
    }
    
    //MARK: - Actions
    
    @objc private func profileWasTapped() {
        //Display the settings controller
        delegate?.wantsToDisplayProfileController()
    }
    
    
    //MARK: - Helper
    
    private func configureConstraints(width: CGFloat?, height: CGFloat?) {
        
        if let width = width {
            constrainWidth(width)
        }
        
        if let height = height {
            constrainHeight(height)
        }
        
    }
    
    public func setProfilePicture(with url: URL) {
        sd_setImage(with: url)
    }
    
    private func setUpTapGesture() {
        
        //Creates the tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileWasTapped))
        
        //Adds the tap gesture
        addGestureRecognizer(tapGesture)
        
    }
    
    /**
     Sets the image view's fields
     */
    private func setImageViewFields() {
        //Set the content mode to aspect fit
        contentMode = .scaleAspectFill
        
        //Clips the image to the imageView
        clipsToBounds = true
        
        //Adds user interaction
        isUserInteractionEnabled = true
        
        //Set border width
        layer.borderWidth = 1
        
        //Set border color
        layer.borderColor = UIColor.lightGray.cgColor
    }
    


}
