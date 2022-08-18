//
//  LoginTextField.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit

class LoginTextField: UITextField {

    //MARK: - Fields
    
    private let CORNER_RADIUS: CGFloat = 22
    private let BORDER_WIDTH: CGFloat = 2
    private let HEIGHT: CGFloat = 52
    
    init(placeHolder: String, isPassword: Bool) {
        super.init(frame: .zero)
        
        configureFields(placeHolder: placeHolder, isPassword: isPassword)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureFields(placeHolder: String, isPassword: Bool) {
        
        //Set background to clear
        backgroundColor = .clear
        
        //Set border width
        layer.borderWidth = BORDER_WIDTH
        
        //Set border color -> white
        layer.borderColor = UIColor.white.cgColor
        
        //Set corner radius
        layer.cornerRadius = CORNER_RADIUS
        
        //Add padding on the left
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        
        leftView = padding
        
        leftViewMode = .always
        
        //Set the place holder text
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor.placeHolderColor])
        
        //Set secure text entry
        isSecureTextEntry = isPassword
        
        //Remove auto capitalization
        autocapitalizationType = .none
        
        //Remove auto correction
        autocorrectionType = .no
        
        //Set keyboard type
        keyboardType = isPassword ? .alphabet : .emailAddress
        
        //Set the height for the text field
        constrainHeight(HEIGHT)
        
        
        
    }

}
