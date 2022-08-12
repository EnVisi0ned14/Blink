//
//  BirthdayTile.swift
//  Blink
//
//  Created by Michael Abrams on 8/5/22.
//

import UIKit

protocol BirthdayTileDelegate: AnyObject {
    func deleteWasPressed(_ textField: BirthdayTile)
}

class BirthdayTile: SingleLineTextField {

    weak var birthdayDelegate: BirthdayTileDelegate?
    
    init(placeHolder: String, lineColor: UIColor = .black, placeHolderColor: UIColor = .placeHolderColor) {
        super.init(placeHolder: placeHolder, lineColor: lineColor, placeHolderColor: placeHolderColor, type: .none)
        
        //Configure fields
        configureFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func deleteBackward() {
        birthdayDelegate?.deleteWasPressed(self)
    }
    
    //MARK: - Helpers
    
    private func configureFields() {
        
        //Update font
        font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        //Set number pad
        keyboardType = .numberPad
    }
    
}
