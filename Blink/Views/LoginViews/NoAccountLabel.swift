//
//  NoAccountLabel.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit

class NoAccountLabel: UILabel {

    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Configure the fields
        configureFields()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    
    private func configureFields() {
        //Set text color
        textColor = .white
        //Set text
        text = "Don't have an account?"
        //Set font
        font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        
    }
}

