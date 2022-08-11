//
//  LoginButton.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit

class LoginButton: UIButton {

    private let HEIGHT: CGFloat = 52
    private let CORNER_RADIUS: CGFloat = 24
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .blinkLabelColor
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureFields()
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureFields() {
        
        //Set corner radius
        layer.cornerRadius = CORNER_RADIUS
        
        //Set the background color
        backgroundColor = .white
        
        //Set the height for the text field
        constrainHeight(HEIGHT)
        
        
    }
    
    private func configureUI() {
        //Add login label
        addSubview(loginLabel)
        
        //Center login label
        loginLabel.centerX(inView: self)
        loginLabel.centerY(inView: self)
        
    }
    
}
