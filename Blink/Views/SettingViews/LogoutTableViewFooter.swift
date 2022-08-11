//
//  LogoutTableViewFooter.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit

protocol LogoutTableViewFooterDelegate: AnyObject {
    func wantsToLogout()
}

class LogoutTableViewFooter: UIView {
    
    
    //MARK: - Fields
    
    private let logoutLabel = CustomLabel(size: 22, weight: .medium, title: "Logout", textColor: #colorLiteral(red: 0.9138069749, green: 0.2994406521, blue: 0.3618122637, alpha: 1))
    
    public weak var delegate: LogoutTableViewFooterDelegate?

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
        addTapGesture()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc private func logoutTapped() {
        delegate?.wantsToLogout()
    }
    
    //MARK: - Helpers
    
    private func addTapGesture() {
        
        //Create tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(logoutTapped))
        
        //Add tap gesture
        addGestureRecognizer(tapGesture)
        
        
    }
    
    private func configureUI() {
        
        //Add subview
        addSubview(logoutLabel)
        
        //Is User Enabled
        isUserInteractionEnabled = true
        
        //Background color white
        backgroundColor = .white
        
        //Center logout label
        logoutLabel.centerX(inView: self)
        logoutLabel.centerY(inView: self)
        
    }

}
