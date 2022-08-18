//
//  MatchImageView.swift
//  Blink
//
//  Created by Michael Abrams on 8/13/22.
//

import UIKit

class MatchImageView: UIImageView {

    //MARK: - Fields
    
    private let HEIGHT: CGFloat = 150
    private let CORNER_RADIUS: CGFloat = 36
    private let BORDER_WIDTH: CGFloat = 4
    private let WIDTH: CGFloat = 150
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        //Constrain width and heigtht
        constrainWidth(WIDTH)
        constrainHeight(HEIGHT)
        
        //Set border width and color
        layer.borderWidth = BORDER_WIDTH
        layer.borderColor = UIColor.white.cgColor
        
        //Set corner radius
        layer.cornerRadius = CORNER_RADIUS
        
        //Set contentMode
        contentMode = .scaleAspectFill
        
        //Set clips to bounds
        clipsToBounds = true
        
    }
    
    public func setProfileImage(with url: URL) {
        sd_setImage(with: url)
    }
    
}
