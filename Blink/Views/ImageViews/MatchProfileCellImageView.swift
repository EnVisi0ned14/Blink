//
//  MatchProfileCellImageView.swift
//  Blink
//
//  Created by Michael Abrams on 8/17/22.
//

import UIKit
import SDWebImage

class MatchProfileCellImageView: UIImageView {

    //MARK: - Fields
    
    private let CORNER_RADIUS: CGFloat = 20
    private let WIDTH: CGFloat = 110
    private let HEIGHT: CGFloat = 150
    
    //MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        
        configureFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Fields
    
    private func configureFields() {
        
        //Constrain the height and width
        constrainHeight(HEIGHT)
        constrainWidth(WIDTH)
        
        //Set corner radius
        layer.cornerRadius = CORNER_RADIUS
        
        //Enable clips to bounds
        clipsToBounds = true
        
        //Set the content mode
        contentMode = .scaleAspectFill
        
    }
    
    public func setImage(withurl url: URL) {
        //Set the image
        sd_setImage(with: url)
    }
    
}
