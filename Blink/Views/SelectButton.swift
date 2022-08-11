//
//  SelectButton.swift
//  Blink
//
//  Created by Michael Abrams on 8/7/22.
//

import UIKit

class SelectButton: UIButton {
    
    //MARK: - Fields
    
    private let buttonTitle = CustomLabel(size: 24, weight: .semibold, title: "", textColor: .black)
    
    private let selectView = SelectView()
    
    private var buttonSelected: Bool = false
    
    private let CORNER_RADIUS: CGFloat = 20
    
    private let LEFT_PADDING: CGFloat = 25
    
    private let HEIGHT: CGFloat = 75

    //MARK: - Lifecycle
    
    init(title: String) {
        super.init(frame: .zero)
        
        //Configure fields
        configureFields(with: title)
        
        //Configure UI
        configureUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        //Add subviews
        addSubview(buttonTitle)
        addSubview(selectView)
        
        //Constrain button title
        buttonTitle.centerY(inView: self)
        buttonTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LEFT_PADDING).isActive = true
        
        //Constrain select view
        selectView.anchor(top: topAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 20))
        
        //Constrain button height
        constrainHeight(HEIGHT)
        
    }
    
    private func configureFields(with title: String) {
        
        //Set corner radius
        layer.cornerRadius = CORNER_RADIUS
        
        //Set background color
        backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        
        //Set label to title
        buttonTitle.text = title
        
        
    }
    
    public func select() {
        
        //Select the select view
        selectView.select()
        
        //Button selected -> true
        buttonSelected = true
        
    }
    
    public func deselect() {
        
        //Deselect the view
        selectView.deselect()
        
        //Button selected -> false
        buttonSelected = false
        
    }
    
    public func isSelected() -> Bool {
        return buttonSelected
    }
    
    
}
