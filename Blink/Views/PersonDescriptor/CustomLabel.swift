//
//  StatsLabel.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

class CustomLabel: UILabel {

    //MARK: - Lifecycle
    
    init(size: CGFloat, weight: UIFont.Weight, title: String = "", textColor: UIColor) {
        super.init(frame: .zero)
        
        configureFields(size: size, weight: weight, title: title, txtColor: textColor)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper
    
    private func configureFields(size: CGFloat, weight: UIFont.Weight, title: String, txtColor: UIColor) {
        
        //Assign the text
        text = title
        
        //Assign the font
        font = UIFont.systemFont(ofSize: size, weight: weight)
        
        //Assign the color
        textColor = txtColor
        
    }


}
