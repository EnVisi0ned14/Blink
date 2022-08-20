//
//  MatchScreenTopStackView.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

protocol MatchScreenTopStackViewDelegate: AnyObject {
    func wantsToPresentProfileController()
    func wantsToPresentSettingsController()
}

class MatchScreenTopStackView: UIStackView {

    //MARK: - Fields
    
    /** Height for the match screen top stack view*/
    private let MATCHSCREEN_TOP_STACK_VIEW_HEIGHT: CGFloat = 100
    
    private let blinkLabel: BlinkLabel = BlinkLabel(blinkLabelType: .topStack)
    private let settingsIcon: SettingsIcon = SettingsIcon(frame: .zero)
    private let profileIcon: ProfileIcon = ProfileIcon(width: 50)
    
    public weak var delegate: MatchScreenTopStackViewDelegate?
    
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Confrom to delegates
        profileIcon.delegate = self
        settingsIcon.delegate = self

        //Adds all the arrange subviews
        [profileIcon, UIView(), blinkLabel, UIView(), settingsIcon].forEach { view in
            addArrangedSubview(view)
        }
        
        //Sets the fields of the stack view
        setStackFields()
        
       
    
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    public func setProfilePicture(with url: URL) {
        profileIcon.setProfilePicture(with: url)
    }
    
    /**
    Sets the stack view's fields
     */
    private func setStackFields() {
        //Set the height
        constrainHeight(MATCHSCREEN_TOP_STACK_VIEW_HEIGHT)
        //Sets the distribution
        distribution = .equalCentering
        //Respects margins
        isLayoutMarginsRelativeArrangement = true
        //Assigns margins
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 32)
    }
    
    public func hideSettingsAndProfile() {
        profileIcon.isHidden = true
        settingsIcon.isHidden = true
    }
}

//MARK: - ProfileIconDelegate
extension MatchScreenTopStackView: ProfileIconDelegate {
    
    func wantsToDisplayProfileController() {
        print("DEBUG: presenting profile...")
        delegate?.wantsToPresentProfileController()
    }
    
}

//MARK: - SettingsIconDelegate
extension MatchScreenTopStackView: SettingsIconDelegate {
    
    func wantsToDisplaySettingsController() {
        print("DEBUG: presenting settings...")
        delegate?.wantsToPresentSettingsController()
    }
    
}
