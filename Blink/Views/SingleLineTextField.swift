//
//  SingleLinexTextField.swift
//  Blink
//
//  Created by Michael Abrams on 8/4/22.
//

import UIKit

enum SingleLineTextFieldType {
    case password
    case name
    case email
    case none
}

class SingleLineTextField: UITextField {

    //MARK: - Fields
    private let HEIGHT: CGFloat = 30
    
    private let lineColor: UIColor
    
    //MARK: - Lifecycle
    init(placeHolder: String,
         lineColor: UIColor = .black,
         placeHolderColor: UIColor = .placeHolderColor,
         type: SingleLineTextFieldType) {
        
        self.lineColor = lineColor
        super.init(frame: .zero)
        
        configureFields(with: placeHolder, for: placeHolderColor, type: type)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setBottomLine(borderColor: lineColor)
    }
    
    
    
    //MARK: - Helpers
    
    private func configureFields(with placeHolder: String,
                                 for placeHolderColor: UIColor,
                                 type: SingleLineTextFieldType) {
        
        //Set the place holder text
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: placeHolderColor])
        
        //No auto correction
        autocorrectionType = .no
        
        //No auto capitilization
        autocapitalizationType = .none
        
        //Configure settings based on type
        configurSettingsForType(for: type)
        

        //Constrian height
        constrainHeight(HEIGHT)
        
        
    }
    
    private func configurSettingsForType(for type: SingleLineTextFieldType) {
        switch type {
        case .password:
            isSecureTextEntry = true
            break
        case .name:
            autocapitalizationType = .words
            break
        case .email:
            keyboardType = .emailAddress
            break
        default:
            break
        }
    }
    
}
