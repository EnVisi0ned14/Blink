//
//  ProfileImageButton.swift
//  Blink
//
//  Created by Michael Abrams on 8/2/22.
//

import UIKit

class ProfileImageButton: UIButton {
    
    //MARK: - Fields

    private let PROFILE_IMAGE_CORNER_RADIUS: CGFloat = 12
    
    private let PADDING_MULTIPLIER: CGFloat = 0.7

    
    private let defaultImage: UIImage = {
        let image = UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate)
        return image!
    }()
    
    //MARK: - Lifecycle
    
    init(image: UIImage?, index: Int?) {
        super.init(frame: .zero)
        
        //Configure the button
        configureButton(image: image, index: index)
        
    }
    
    convenience init() {
        self.init(image: nil, index: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let paddingMultiplier = frame.width * PADDING_MULTIPLIER
        
        //If the image is a plus button
        if(imageView?.image == defaultImage) {
            imageEdgeInsets = UIEdgeInsets(top: paddingMultiplier,
                                           left: paddingMultiplier,
                                           bottom: paddingMultiplier,
                                           right: paddingMultiplier)
        }

        
        
        
    }
    
    
    //MARK: - Helpers
    
    public func uploadPhoto(with photo: UIImage) {
        
        //Set the image
        setImage(photo, for: .normal)
        
        //Remove padding
        imageEdgeInsets = .zero
        
        
        
    }
    
    private func configureButton(image: UIImage?, index: Int?) {
        
        //Set the tag for the button, or 0 if nil
        tag = index ?? 0
        
        //Clips to bounds
        clipsToBounds = true
        
        //Corner Radius
        layer.cornerRadius = PROFILE_IMAGE_CORNER_RADIUS
        
        //Set the background color
        backgroundColor = .profileButtonBackgroundColor
        
        //Set the image for the button
        image == nil ? setImage(defaultImage, for: .normal): setImage(image, for: .normal)
        
        //Set the tint color
        imageView?.tintColor = .profilePlusTintColor
        
        //Image fills the button
        imageView?.contentMode = .scaleAspectFill
        
        //Lets the plus scale
        contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.fill
        contentVerticalAlignment = UIControl.ContentVerticalAlignment.fill
        
        //Remove highlighting when button selected
        adjustsImageWhenHighlighted = false
        
        //Prevents from turning grey
        tintAdjustmentMode = .normal
        
    
    }
    
}
