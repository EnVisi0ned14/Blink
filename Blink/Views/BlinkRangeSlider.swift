//
//  BlinkRangeSlider.swift
//  Blink
//
//  Created by Michael Abrams on 8/7/22.
//

import Foundation
import RangeSeekSlider

enum RangeSliderType {
    case oneHandle
    case twoHandles
}

public class BlinkRangeSlider: RangeSeekSlider {
    
    //MARK: - Fields
    
    private let LINE_HEIGHT: CGFloat = 5
    
    private let HANDLE_BORDER_WIDTH: CGFloat = 1
    
    private let SELECTED_MULTIPLIER: CGFloat = 1.5
    
    
    //MARK: - Lifecycle
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        
        configureFields()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    
    private func configureFields() {
        
        //Set handle color
        handleColor = .white
        
        //Set line height
        lineHeight = LINE_HEIGHT
        
        //Hide labels
        hideLabels = true
        
        //Color between handles
        colorBetweenHandles = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        //Tint color (color outside the two handles)
        tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        //Border width
        handleBorderWidth = HANDLE_BORDER_WIDTH
        
        //Handle border color
        handleBorderColor = .black
        
        //Selected multiplier
        selectedHandleDiameterMultiplier = SELECTED_MULTIPLIER
        
    }
    
}
