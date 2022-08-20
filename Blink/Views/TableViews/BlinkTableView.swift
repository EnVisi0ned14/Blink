//
//  BlinkTableView.swift
//  Blink
//
//  Created by Michael Abrams on 8/18/22.
//

import UIKit

enum BlinkTableViewType {
    case settingsTableView
    case profileTableView
    case conversationTableView
}

class BlinkTableView: UITableView {
    
    //MARK: - Lifecycle
    
    init(for type: BlinkTableViewType) {
        
        //Grouped prevents sticky header sections
        let style: UITableView.Style = type == .conversationTableView ? .grouped : .plain
        
        //Initalize with style
        super.init(frame: .zero, style: style)
        
        //Configure the table view's fields
        configureFields(for: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureFields(for type: BlinkTableViewType) {
        

        switch type {
        case .profileTableView:
            configureProfileTableView()
        case .settingsTableView:
            configureSettingsTableView()
        case .conversationTableView:
            configureConversationTableView()
        }
        
    }
    
    private func configureProfileTableView() {
        //Register cell
        register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        //Seperator style -> None
        separatorStyle = .none
        //Background color is white
        backgroundColor = .white
    }
    
    private func configureSettingsTableView() {
        //Register cells
        register(SettingsSliderTableViewCell.self,
                           forCellReuseIdentifier: SettingsSliderTableViewCell.identifier)
        register(SettingsGenderTableViewCell.self,
                           forCellReuseIdentifier: SettingsGenderTableViewCell.identifier)
        register(LogoutTableViewCell.self,
                           forCellReuseIdentifier: LogoutTableViewCell.identifier)
        //Set background color
        backgroundColor = #colorLiteral(red: 0.9567686915, green: 0.9569286704, blue: 0.9567475915, alpha: 1)
    }
    
    private func configureConversationTableView() {
        //Background color to white
        backgroundColor = .white
        //Register cell
        register(CollectionTableViewCell.self,
                 forCellReuseIdentifier: CollectionTableViewCell.identifier)
        register(ConversationTableViewCell.self,
                 forCellReuseIdentifier: ConversationTableViewCell.identifier)
        //Seperator style -> None
        separatorStyle = .none
        //Create grouped style

    }
    
}
