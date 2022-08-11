//
//  SettingsIcon.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

protocol SettingsIconDelegate: AnyObject {
    func wantsToDisplaySettingsController()
}

class SettingsIcon: UIImageView {

    //MARK: - Fields
    let SETTINGS_ICON_WIDTH = 40
    let SETTINGS_ICON_HEIGHT = 40
    
    
    weak var delegate: SettingsIconDelegate?
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(image: UIImage(systemName: "gear"))
        
        //Sets the image view's fields
        setImageViewFields()
        
        //Set the image view's constraints
        setImageViewConstraints()
        
        //Set up the tap register for the settings icon
        setUpTapGesture()
        
    }
    
    //Required decoder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc private func settingsIconTapped() {
        delegate?.wantsToDisplaySettingsController()
    }
    
    //MARK: - Helper
    
    private func setUpTapGesture() {
        //Create the tap register
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(settingsIconTapped))
        //Add the tap gesture
        addGestureRecognizer(tapGesture)
    }
    
    /**
     Sets the image view's fields
     */
    private func setImageViewFields() {
        //Set the content mode to aspect fit
        contentMode = .scaleAspectFill
        
        //Set the tint color to dark gray
        tintColor = .lightGray
        
        //Enables touch
        isUserInteractionEnabled = true
    }
    
    /**
     Sets the image view's constraints
     */
    private func setImageViewConstraints() {
        //Sets the frame to SETTINGS_ICON_WIDTH x SETTINGS_ICON_HEIGHT
        frame.size = CGSize(width: SETTINGS_ICON_WIDTH, height: SETTINGS_ICON_HEIGHT)
    }
    
}
