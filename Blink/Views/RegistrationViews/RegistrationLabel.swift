//
//  RegistrationLabel.swift
//  Blink
//
//  Created by Michael Abrams on 8/4/22.
//

import UIKit

class RegistrationLabel: UILabel {

    
    init(text: String) {
        super.init(frame: .zero)
        
        configureFields(with: text)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func configureFields(with text: String) {
        
        //Assign the text
        self.text = text
        
        //Change text color to black
        textColor = .black
        
        //Set font size
        font = UIFont.systemFont(ofSize: 50, weight: .bold)
        
        
    }
    
    

}
