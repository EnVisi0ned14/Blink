//
//  CollectionTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 8/17/22.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    //MARK: - Fields
    
    public static let identifier = "CollectionTableViewCell"
    
    public var matches: [Match]! {
        didSet{matchesCollectionView.reloadData()}
    }
    
    private let matchesCollectionView = HorizontalScrollableCollectionView()

    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        //Register collection view
        matchesCollectionView.register(MatchesCollectionViewCell.self,
                                       forCellWithReuseIdentifier: MatchesCollectionViewCell.identifier)
        
        matchesCollectionView.delegate = self
        matchesCollectionView.dataSource = self
        
        //Constrain collection view
        contentView.addSubview(matchesCollectionView)
        matchesCollectionView.fillSuperview()
        
    }
    

}

//MARK: - UICollectionViewDelegate

extension CollectionTableViewCell: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDatasource

extension CollectionTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchesCollectionViewCell.identifier, for: indexPath) as! MatchesCollectionViewCell
        cell.match = matches[indexPath.row]
        return cell
    }
    
    
}


//MARK: - UICollectionViewDelegateFlowLayout

extension CollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 175)
    }
}
