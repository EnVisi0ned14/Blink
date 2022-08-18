//
//  BlinkBorderButton.swift
//  Blink
//
//  Created by Michael Abrams on 8/13/22.
//

import Foundation

public class BlinkBorderButton: BlinkButton {
    
    override init(title: String) {
        super.init(title: title)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        configureUI()
    }
    
    private func configureUI() {
        
        //Enable continue button
        enableContinueButton()
        
        //Remove gradient layer
        removeGradientLayer()
        
        //Set background to clear
        backgroundColor = .clear
        
        //Clips to bounds
        clipsToBounds = true
        
        //Configure border gradient
        configureBorderGradient()

    }
}
