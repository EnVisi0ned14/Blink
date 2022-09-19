//
//  StatIconImageView.swift
//  Blink
//
//  Created by Michael Abrams on 9/18/22.
//

import UIKit

class CustomImageView: UIImageView {

    //MARK: - Initlizer
    
    init(height: CGFloat = 0, width: CGFloat = 0, contentMode: ContentMode = .scaleAspectFill) {
        super.init(frame: .zero)
        
        //Constrain the height and width
        setDimensions(height: height, width: width)
        
        //Set the content mode
        self.contentMode = contentMode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}
