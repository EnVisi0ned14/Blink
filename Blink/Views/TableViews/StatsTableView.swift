//
//  StatsTableView.swift
//  Blink
//
//  Created by Michael Abrams on 9/14/22.
//

import Foundation
import UIKit

public class StatsTableView: UITableView {
    
    //MARK: - Fields
    
    public var user: User! {
        didSet { configure() }
    }
    
    //MARK: - Lifecycle
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        //Configure fields
        configureFields()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureFields() {
        
        //Register the stats table view cell
        register(StatsTableViewCell.self, forCellReuseIdentifier: StatsTableViewCell.identifier)
        register(AboutMeTableViewCell.self, forCellReuseIdentifier: AboutMeTableViewCell.identifier)
        register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        register(ReportTableViewCell.self, forCellReuseIdentifier: ReportTableViewCell.identifier)
        
        //Seperator style -> None
        separatorStyle = .none
        //Background color is white
        backgroundColor = .white

        
    }
    
    private func configure() {
        
    }
    
}
