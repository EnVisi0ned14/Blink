//
//  ReportTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 9/19/22.
//

import UIKit

class ReportTableViewCell: AbstractStatsTableViewCell {

    //MARK: - Fields
    
    private let reportLabel = CustomLabel(size: 30, weight: .semibold, textColor: #colorLiteral(red: 0.3060859442, green: 0.2971302271, blue: 0.2969383597, alpha: 1))
    
    public static let identifier: String = "ReportTableViewCell"
    
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
        reportLabel.text = "REPORT \(viewModel.firstName.uppercased())"
    }
    
    private func configureUI() {
        
        //Update the selectionStyle
        selectionStyle = .blue
        
        //Add subview
        contentView.addSubview(reportLabel)
        
        //Constrain reportLabel
        reportLabel.centerInSuperview()
        
    }
    
}
