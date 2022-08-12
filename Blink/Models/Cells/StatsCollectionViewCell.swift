//
//  StatsCollectionViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 8/11/22.
//

import UIKit

class StatsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Fields
    
    public static let identifier = "StatsCollectionViewCell"
    
    let imageView = UIImageView()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        //Add subview
        addSubview(imageView)
        //Scale to fill
        imageView.contentMode = .scaleAspectFill
        //Fill superview
        imageView.fillSuperview()
    }
    
}
