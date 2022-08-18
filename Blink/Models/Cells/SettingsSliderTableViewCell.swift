//
//  SettingsSliderTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 8/2/22.
//

import UIKit
import RangeSeekSlider



class SettingsSliderTableViewCell: PreferenceCellTableViewCell {

    //MARK: - Fields

    public static let identifier = "SettingsSliderTableViewCell"
    
    private let slider = BlinkRangeSlider()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Configure the UI
        configureUI()
        
        //Add target for the slider
        slider.delegate = self


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    
    private func configureUI() {
        contentView.addSubview(preferenceLabel)

        selectionStyle = .none
        
        preferenceLabel.anchor(top: topAnchor, leading: leadingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0))
        
        
        let sliderStack = UIStackView(arrangedSubviews: [statusLabel, slider])
        
        sliderStack.distribution = .fill
        sliderStack.spacing = 10
        contentView.addSubview(sliderStack)

        sliderStack.anchor(top: preferenceLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 30, bottom: 10, right: 30))



    }
    
    //CALLED WHEN VIEW MODEL IS UPDATED
    public override func configure() {
        
        //Sets the number of handles
        slider.disableRange = !settingsViewModel.shouldEnableDoubleSlider

        //Assign the min
        if(settingsViewModel.shouldEnableDoubleSlider) {
            slider.minValue = settingsViewModel.minSliderValue
            slider.selectedMinValue = settingsViewModel.lowerSliderValue
        }
        
        //Assin the max
        slider.maxValue = settingsViewModel.maxSliderValue
        slider.selectedMaxValue = settingsViewModel.upperSliderValue
        
        //Update user and label
        updateUserAndLabel()

        //Assign the text to the preference label
        preferenceLabel.text = settingsViewModel.cellLabel
        
        
        
    }
    
    private func updateUserAndLabel() {
        
        switch settingsViewModel.section {
        case .age:
            settingsViewModel.user.userSettings.minSeekingAge = Int(slider.selectedMinValue)
            settingsViewModel.user.userSettings.maxSeekingAge = Int(slider.selectedMaxValue)
            statusLabel.text = settingsViewModel.ageLabelText
        case .distance:
            settingsViewModel.user.userSettings.distanceRange = Int(slider.selectedMaxValue)
            statusLabel.text = settingsViewModel.distanceLabelText
        default:
            break
            
        }
    }
    

}


extension SettingsSliderTableViewCell: RangeSeekSliderDelegate {
    
    //Detect changes in seek slider
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        updateUserAndLabel()
    }
    
}
