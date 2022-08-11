//
//  BlinkLabel.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

enum BlinkLabelType {
    case loginPage
    case topStack
    
    var size: CGFloat {
        switch self {
        case .loginPage: return 120
        case .topStack: return 60
        }
    }
    
    var color: UIColor {
        switch self {
        case .loginPage: return .white
        case .topStack: return .blinkLabelColor
        }
    }
}

class BlinkLabel: UILabel {

    
    //MARK: - Lifecycle
    init(blinkLabelType: BlinkLabelType) {
        super.init(frame: .zero)
        
        //Set the text for the label
        text = "Blink";
        //Set the color for the label
        textColor = blinkLabelType.color
        //Sets the size of text and makes bold
        font = UIFont.systemFont(ofSize: blinkLabelType.size, weight: .bold)
        

        
        
        
    }
    
    //Required Coder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
