//
//  AboutMeTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 9/18/22.
//

import UIKit

class AboutMeTableViewCell: AbstractStatsTableViewCell {

    //MARK: - Fields
    
    private let aboutMeLabel = CustomLabel(size: 18, weight: .medium, textColor: #colorLiteral(red: 0.5529411765, green: 0.5333333333, blue: 0.5333333333, alpha: 1))
    
    public static let identifier: String = "AboutMeTableViewCell"
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Configure UI
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    override func configure() {
        aboutMeLabel.text = viewModel.aboutMe
    }
    
    private func configureUI() {
        
        //Add subview
        contentView.addSubview(aboutMeLabel)
        
        //Constrain aboutMeLabel
        aboutMeLabel.anchor(left: contentView.leadingAnchor, paddingLeft: 15)
        aboutMeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
}
