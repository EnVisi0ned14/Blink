//
//  BlinkTopStackView.swift
//  Blink
//
//  Created by Michael Abrams on 8/17/22.
//

import UIKit

class BlinkTopStackView: UIStackView {

    //MARK: - Fields
    
    /** Height for the match screen top stack view*/
    private let MATCHSCREEN_TOP_STACK_VIEW_HEIGHT: CGFloat = 100
    
    public let blinkLabel: BlinkLabel = BlinkLabel(blinkLabelType: .topStack)
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [UIView(), blinkLabel, UIView()].forEach({addArrangedSubview($0)})
        
        setStackFields()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func setStackFields() {
        
        //Set the height
        constrainHeight(MATCHSCREEN_TOP_STACK_VIEW_HEIGHT)
        //Sets the distribution
        distribution = .equalCentering
        //Respects margins
        isLayoutMarginsRelativeArrangement = true
        //Assigns margins
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }

}
