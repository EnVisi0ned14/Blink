//
//  ProfileIcon.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

protocol ProfileIconDelegate: AnyObject {
    
    func wantsToDisplayProfileController()
    
}


class ProfileIcon: UIImageView {
    
    //MARK: - Fields
    
    private let PROFILE_ICON_WIDTH: CGFloat = 50
    
    public weak var delegate: ProfileIconDelegate?
    
    //MARK: - Lifecycle
    
    init() {
        super.init(image: UIImage(named: "daisy"))
        
        //Set the image view's constraints
        setImageViewConstraints()
        
        //Sets the image view's fields
        setImageViewFields()
        
        //Set up the tap gesture
        setUpTapGesture()
    }
    
    //Required decoder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc private func profileWasTapped() {
        //Display the settings controller
        delegate?.wantsToDisplayProfileController()
    }
    
    //MARK: - Helper
    
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
        
        //Set the image view to a circle
        layer.cornerRadius = PROFILE_ICON_WIDTH / 2
        
        //Clips the image to the imageView
        clipsToBounds = true
        
        //Adds user interaction
        isUserInteractionEnabled = true
    }
    
    /**
     Sets the image view's constraints
     */
    private func setImageViewConstraints() {
        
        //Sets the frame to SETTINGS_ICON_WIDTH x SETTINGS_ICON_HEIGHT
        constrainWidth(PROFILE_ICON_WIDTH)
        
    }

}
