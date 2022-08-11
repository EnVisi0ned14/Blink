//
//  BlinkPlusTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit

protocol BlinkPlusTableViewHeaderDelegate: AnyObject {
    func blinkPlusTapped()
}

class BlinkPlusTableViewHeader: UIView {

    //MARK: - Fields
    
    private let blinkPlusButton: BlinkPlusButton = BlinkPlusButton()
    
    public weak var delegate: BlinkPlusTableViewHeaderDelegate?
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Set the delegate
        blinkPlusButton.delegate = self
        
        
    }
    
    override func layoutSubviews() {
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        addSubview(blinkPlusButton)
        
        blinkPlusButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 25, left: 20, bottom: 25, right: 20))
    }
    
}

//MARK: - BlinkPlusButtonDelegate
extension BlinkPlusTableViewHeader: BlinkPlusButtonDelegate {
    
    func blinkPlusTapped() {
        delegate?.blinkPlusTapped()
    }
    
}
