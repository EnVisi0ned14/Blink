//
//  StatsCollectionView.swift
//  Blink
//
//  Created by Michael Abrams on 8/11/22.
//

import UIKit

class StatsCollectionView: UICollectionView {

    //MARK: - Lifecycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        //Configure Fields
        configureFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureFields() {
        
        //Paging enabled
        isPagingEnabled = true
        //Shows Scroll indicator
        showsHorizontalScrollIndicator = false
        
        //Register cell
        register(StatsCollectionViewCell.self,
                 forCellWithReuseIdentifier: StatsCollectionViewCell.identifier)
        
        //Turn off consetInset
        contentInsetAdjustmentBehavior = .never
        contentInset = .zero
        
        
    }
}
