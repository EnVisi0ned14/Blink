//
//  ContinueButton.swift
//  Blink
//
//  Created by Michael Abrams on 8/4/22.
//

import UIKit

public class BlinkButton: UIButton {

    //MARK: - Fields
    
    private let CORNER_RADIUS: CGFloat = 22
    
    private let HEIGHT: CGFloat = 52
    
    private let textLabel = CustomLabel(size: 24, weight: .semibold, title: "", textColor: .white)
    
    //MARK: - Lifecycle
    init(title: String) {
        super.init(frame: .zero)
        
        configureFields(with: title)
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureFields(with title: String) {

        //Add subview
        addSubview(textLabel)
        
        //Set corner radius
        layer.cornerRadius = CORNER_RADIUS
        
        //Center continue label
        textLabel.centerInSuperview()
        
        //Set title
        textLabel.text = title
        
        //Set height
        constrainHeight(HEIGHT)
        
        //Set clips to bounds
        clipsToBounds = true
        
        //Gray background color
        backgroundColor = .gray
        
        //Disabled by default
        isEnabled = false
        
        
    }
    
    public func enableContinueButton() {

        //If already has a gradient layer
        if(hasGradientLayer()) {
            return
        }
        
        //Add gradient layer
        configureGradientLayer()
        
        //Enable the button
        isEnabled = true
        
    }
    
    
    public func disableContinueButton() {
        //Remove the gradient layer
        removeGradientLayer()
        //Add gray background
        backgroundColor = .gray
        //Disable button
        isEnabled = false
    }
    
    
}
