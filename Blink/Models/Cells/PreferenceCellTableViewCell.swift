//
//  SettingCellTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit

class PreferenceCellTableViewCell: UITableViewCell {

    //MARK: - Fields
    
    public var settingsViewModel: SettingsViewModel! {
        didSet { configure() }
    }
    
    public let preferenceLabel = CustomLabel(size: 20, weight: .semibold, textColor: .black)
    
    public let statusLabel = CustomLabel(size: 18, weight: .semibold, textColor: .settingStatusColor)

    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //Abstract function: Is called when settingsViewModel is set. Should configure fields
    func configure() {
        
    }

}
