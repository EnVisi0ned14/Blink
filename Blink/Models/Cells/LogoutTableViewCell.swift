//
//  LogoutTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 8/8/22.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {

    //MARK: - Fields
    
    private let logoutLabel = CustomLabel(size: 22, weight: .medium, title: "Logout", textColor: .black)
    
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
        
        contentView.addSubview(logoutLabel)
        
        backgroundColor = .white
        
        //Center logout label
        logoutLabel.centerX(inView: self)
        logoutLabel.centerY(inView: self)
        
    }
    
}

