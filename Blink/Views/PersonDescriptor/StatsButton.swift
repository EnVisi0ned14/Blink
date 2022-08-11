//
//  StatsButton.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

class StatsButton: UIButton {
    
    /** STATS_BUTTON_CORNER_RADIUS is the corner radius for the stats button*/
    private let STATS_BUTTON_CORNER_RADIUS: CGFloat = 28
    
    private let statsLabel = CustomLabel(size: 30, weight: .bold, title: "Stats", textColor: .white)

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureFields()
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        //Configure the gradient layer
        configureGradientLayer()
    }
    
    
    //MARK: - Helper
    
    //Configures the field's for the button
    private func configureFields() {
        
        //Set the corner radius for the button
        layer.cornerRadius = STATS_BUTTON_CORNER_RADIUS
        //Clips to bounds
        clipsToBounds = true
        
    }
    
    //Configures the UI for the button
    private func configureUI() {
        
        //Configures the button's gradient layer
        configureGradientLayer()
        
        //Adds the stat's label as a view
        addSubview(statsLabel)
        
        //Center the stat's label in view
        statsLabel.centerInSuperview()
        
        
    }

}
