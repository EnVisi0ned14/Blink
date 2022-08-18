//
//  MatchesCollectionView.swift
//  Blink
//
//  Created by Michael Abrams on 8/17/22.
//

import UIKit

class HorizontalScrollableCollectionView: UICollectionView {

    //MARK: - Fields

    
    //MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        configureFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureFields() {
        
        //Set background to white
        backgroundColor = .white
        //Create flow layout
        let layout = UICollectionViewFlowLayout()
        //Horizontal scrolling
        layout.scrollDirection = .horizontal
        //Set layout
        collectionViewLayout = layout
        //Enable scrolling
        isScrollEnabled = true
        //Disable vertical and horizontal scroll bar
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
    }
    
    

}
