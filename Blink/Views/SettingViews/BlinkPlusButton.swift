//
//  BlinkPlusButton.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit

protocol BlinkPlusButtonDelegate: AnyObject {
    func blinkPlusTapped()
}

class BlinkPlusButton: UIButton {
    
    //MARK: - Fields
    
    private let CORNER_RADIUS: CGFloat = 12
    
    private let blinkPlusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.text = "Blink +"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .blinkPlusDescriptionColor
        label.text = "See Who Likes You"
        return label
    }()
    
    public weak var delegate: BlinkPlusButtonDelegate?
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        //Add target for button
        addTarget(self, action: #selector(blinkPlusTapped), for: .touchUpInside)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        //Configure the Button
        configureButton()
        
        //Configure the UI
        configureUI()
    }
    
    //MARK: - Actions
    @objc private func blinkPlusTapped() {
        delegate?.blinkPlusTapped()
    }
    
    //MARK: - Helpers
    
    private func configureButton() {
        
        //Set the corner radius
        layer.cornerRadius = CORNER_RADIUS
        
        //Apply the gradient
        configureGradientLayer()
        
        //Adds clipping
        clipsToBounds = true
    }
    
    private func configureUI() {
        
        //Add subviews
        addSubview(blinkPlusLabel)
        addSubview(descriptionLabel)
        
        //Anchor the blink label to the center, 10 points from top
        blinkPlusLabel.anchor(top: topAnchor, paddingTop: 10)
        blinkPlusLabel.centerX(inView: self)
        
        //Anchor the description text right below
        descriptionLabel.anchor(top: blinkPlusLabel.bottomAnchor, paddingTop: 5)
        descriptionLabel.centerX(inView: self)
        
    }
    
}
