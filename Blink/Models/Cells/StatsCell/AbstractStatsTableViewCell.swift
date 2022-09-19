//
//  AbstractStatsTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 9/18/22.
//

import UIKit

class AbstractStatsTableViewCell: UITableViewCell {
    
    //MARK: - Fields
    
    public var viewModel: StatViewModel! {
        didSet { configure() }
    }
    
    //MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Change the selection style to none
        selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    //Abstract function: called when stats view model is set
    func configure() {
        
    }
    
}
