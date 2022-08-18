//
//  MatchLabel.swift
//  Blink
//
//  Created by Michael Abrams on 8/13/22.
//

import UIKit

class MatchLabel: UIImageView {

    init() {
        super.init(frame: .zero)
        
        configureFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureFields() {
        
        contentMode = .scaleAspectFit

        image = #imageLiteral(resourceName: "MatchLabel")
    }

}
