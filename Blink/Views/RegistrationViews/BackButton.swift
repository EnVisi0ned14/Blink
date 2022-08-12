//
//  BackButton.swift
//  Blink
//
//  Created by Michael Abrams on 8/4/22.
//

import UIKit

class BackButton: UIButton {
    
    private let HEIGHT: CGFloat = 50
    
    private let WIDTH: CGFloat = 50
    
    private let redXImageView: UIImageView = {
        let imageView = UIImageView()
        
        let image = UIImage(systemName: "lessthan")?.withRenderingMode(.alwaysTemplate)
        
        imageView.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureFields()
        
        configureUI()
        
    }
    
    override func layoutSubviews() {
        
        //Set corner radius
        layer.cornerRadius = frame.width / 2
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureFields() {
        
        //Clips to bounds
        clipsToBounds = true
        
        //Set aspect fill
        imageView?.contentMode = .scaleAspectFill
        
        //Constrain size
        constrainHeight(HEIGHT)
        constrainWidth(WIDTH)

        
    }
    
    private func configureUI() {
        
        addSubview(redXImageView)
        
        redXImageView.fillSuperview()
        
    }
    
    

}
