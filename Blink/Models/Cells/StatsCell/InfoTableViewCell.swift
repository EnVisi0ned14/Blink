//
//  InfoTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 9/18/22.
//

import UIKit

class InfoTableViewCell: AbstractStatsTableViewCell {

    //MARK: - Fields
    
    private let infoImageView: CustomImageView = CustomImageView(height: 35, width: 35, contentMode: .scaleAspectFit)

    private let infoLabel = CustomLabel(size: 24, weight: .medium, textColor: #colorLiteral(red: 0.4834214449, green: 0.4834213853, blue: 0.4834214449, alpha: 1))
    
    public static let identifier = "InfoTableViewCell"
    
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
        infoLabel.text = viewModel.infoText
        infoImageView.image = viewModel.infoIcon
    }
    
    private func configureUI() {
        
        //Add subviews to the contentView
        [infoImageView, infoLabel].forEach({contentView.addSubview($0)})
        
        //Constrain the statImageView (15 blank points above the cell)
        infoImageView.anchor(top: contentView.topAnchor, left: contentView.leadingAnchor, bottom: contentView.bottomAnchor, paddingTop: 15, paddingLeft: 15, width: 35)
        
        //Constrain the statistics label
        infoLabel.anchor(left: infoImageView.trailingAnchor, right: contentView.trailingAnchor, paddingLeft: 15)
        infoLabel.centerYAnchor.constraint(equalTo: infoImageView.centerYAnchor).isActive = true
        
    }

}
