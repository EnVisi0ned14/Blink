//
//  ConversationViewModel.swift
//  Blink
//
//  Created by Michael Abrams on 8/18/22.
//

import UIKit

protocol ConversationCellItem {}

struct MatchSection: ConversationCellItem {
    
    let titleForSection = "Matches"
    let cellHeight: CGFloat = 200
    let identifier = CollectionTableViewCell.identifier
    
}

struct ConversationSection: ConversationCellItem {
    let titleForSection = "Conversations"
    let cellHeight: CGFloat = 200
    let identifier = CollectionTableViewCell.identifier
}





 
