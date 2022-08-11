//
//  SignUpButton.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit

protocol SignUpButtonDelegate: AnyObject {
    func wantsToDisplayRegistrationController()
}

class SignUpButton: UIButton {
    
    //MARK: - Fields
    
    weak var delegate: SignUpButtonDelegate?

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Configure the button
        configureButton()
        
        //Add target
        addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc private func signUpButtonTapped() {
        delegate?.wantsToDisplayRegistrationController()
    }
    
    //MARK: - Helpers
    
    private func configureButton() {
        //Clear background
        backgroundColor = .clear
        //Set title
        setTitle("Sign up", for: .normal)
        //Set color
        setTitleColor(#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.2862745098, alpha: 1), for: .normal)
        //Set font
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
    }
    
}
