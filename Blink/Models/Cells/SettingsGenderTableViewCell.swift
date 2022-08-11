//
//  SettingsGenderTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 8/7/22.
//

import UIKit

class SettingsGenderTableViewCell: PreferenceCellTableViewCell {

    //MARK: - Fields
    
    public static let identifier = "SettingsGenderTableViewCell"
    
    private let cellLabel = CustomLabel(size: 20, weight: .semibold, textColor: .black)
    
    private let selectionLabel = CustomLabel(size: 20, weight: .medium, textColor: #colorLiteral(red: 0.2941176471, green: 0.2823529412, blue: 0.2823529412, alpha: 1))
        
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    override func configure() {
        
        //Set the text for the cell
        cellLabel.text = settingsViewModel.cellLabel
        
        //Set the selection text
        if(settingsViewModel.section == .genderPreference) {
            selectionLabel.text = settingsViewModel.showMeText
        }
        else {
            selectionLabel.text = settingsViewModel.genderText
        }
        
    }
    
    private func configureUI() {
        
        //Add subviews
        contentView.addSubview(cellLabel)
        contentView.addSubview(selectionLabel)
        
        //Configure cell label
        cellLabel.centerY(inView: self)
        cellLabel.anchor(left: leadingAnchor, paddingLeft: 15)
        
        //Configure selection label
        selectionLabel.centerY(inView: self)
        selectionLabel.anchor(right: trailingAnchor, paddingRight: 50)
        
    }
    

}
