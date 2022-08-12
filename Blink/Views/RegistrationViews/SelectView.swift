//
//  SelectVIew.swift
//  Blink
//
//  Created by Michael Abrams on 8/7/22.
//

import UIKit

class SelectView: UIView {

    
    //MARK: - Fields
    
    private let BORDER_WIDTH: CGFloat = 2
    
    private let WIDTH: CGFloat = 35
    
    private let HEIGHT: CGFloat = 35
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        //Configure Fields
        configureFields()
        
        //Configure UI
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Update corner radius
        layer.cornerRadius = frame.width / 2
        
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        //Constrain width
        constrainWidth(WIDTH)
        //Consrain height
        constrainHeight(HEIGHT)
    }
    
    private func configureFields() {
        
        //Background color clear
        backgroundColor = .clear
        
        //Set borderColor
        layer.borderColor = #colorLiteral(red: 0.4078431373, green: 0.4078431373, blue: 0.4078431373, alpha: 1)
        
        //Set border width
        layer.borderWidth = BORDER_WIDTH
        
        //Remove interaction
        isUserInteractionEnabled = false
        
    }
    
    
    public func select() {
        
        //Update background color
        backgroundColor = .black
        
        //Update border color
        layer.borderColor = UIColor.black.cgColor
        
    }
    
    public func deselect() {
        
        //Update background color
        backgroundColor = .clear
        
        //Update borderColor
        layer.borderColor = #colorLiteral(red: 0.4078431373, green: 0.4078431373, blue: 0.4078431373, alpha: 1)
        
    }

}
