//
//  LogoutTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 8/8/22.
//

import UIKit

class LogoutTableViewCell: PreferenceCellTableViewCell {

    //MARK: - Fields
    
    private let logoutLabel = CustomLabel(size: 22, weight: .medium, title: "Logout", textColor: #colorLiteral(red: 0.9138069749, green: 0.2994406521, blue: 0.3618122637, alpha: 1))
    
    public static let identifier = "LogoutTableViewCell"
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helpers
    
    private func configureUI() {
        
        //Add subview
        contentView.addSubview(logoutLabel)
        
        //Set border color
        backgroundColor = .white
        
        //Set border color
        layer.borderColor = UIColor.separator.cgColor
        
        //Set border width
        layer.borderWidth = 1
        
        //Center logout label
        logoutLabel.centerX(inView: self)
        logoutLabel.centerY(inView: self)
        
        
    }
    
    override func configure() {
        
    }
    
}

