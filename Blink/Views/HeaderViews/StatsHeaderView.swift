//
//  StatsHeaderView.swift
//  Blink
//
//  Created by Michael Abrams on 9/18/22.
//

import UIKit

class StatsHeaderView: UIView {
    
    //MARK: - Fields
    
    //First name label
    private let firstNameLabel = CustomLabel(size: 64, weight: .bold, textColor: #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1))
    
    //Age label
    private let ageLabel = CustomLabel(size: 45, weight: .medium, textColor: .black)
    
    //Height for the header view
    public static let height: CGFloat = 80
    
    //MARK: - Lifecycle
    
    init(userProfile: UserProfile) {
        super.init(frame: .zero)
        
        //Initalize class fields
        self.firstNameLabel.text = userProfile.firstName
        self.ageLabel.text = String(userProfile.age)
        
        //Add subviews
        [firstNameLabel, ageLabel].forEach({addSubview($0)})
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        //Constrain the firstNameLabel
        firstNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        firstNameLabel.anchor(left: leadingAnchor, paddingLeft: 15)
        
        //Constrain the age label
        ageLabel.anchor(left: firstNameLabel.trailingAnchor, paddingLeft: 5)
        ageLabel.lastBaselineAnchor.constraint(equalTo: firstNameLabel.lastBaselineAnchor).isActive = true
        
        
    }

    
    
}
