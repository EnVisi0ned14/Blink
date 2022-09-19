//
//  StatsTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 9/14/22.
//

import UIKit

class StatsTableViewCell: AbstractStatsTableViewCell {
    
    //MARK: - Fields
    
    private let statImageView: CustomImageView = CustomImageView(height: 35, width: 35)
    
    private let statisticsLabel: UILabel = UILabel()
    
    public static let identifier = "StatsTableViewCell"

    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Configure the UI for the cell
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        //Add subviews to the contentView
        [statImageView, statisticsLabel].forEach({contentView.addSubview($0)})
        
        //Constrain the statImageView (15 blank points above the cell)
        statImageView.anchor(top: contentView.topAnchor, left: contentView.leadingAnchor, bottom: contentView.bottomAnchor, paddingTop: 15, paddingLeft: 15, width: 35)
        
        //Constrain the statistics label
        statisticsLabel.anchor(left: statImageView.trailingAnchor, right: contentView.trailingAnchor, paddingLeft: 15)
        statisticsLabel.centerYAnchor.constraint(equalTo: statImageView.centerYAnchor).isActive = true
        
    }
    
    override func configure() {
        
        //Set the icon image
        statImageView.image = viewModel.statsIcon
        
        //Set the label text
        statisticsLabel.attributedText = viewModel.statsText
        
    }

}
