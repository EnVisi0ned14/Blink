//
//  ImageButton.swift
//  Blink
//
//  Created by Michael Abrams on 8/11/22.
//

import UIKit

class ImageButton: UIButton {

    //MARK: - Lifecycle
    
    init(image: UIImage) {
        super.init(frame: .zero)
        
        configureFields(withimage: image)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureFields(withimage image: UIImage) {
        
        //Set the image
        setImage(image, for: .normal)
    }

}
