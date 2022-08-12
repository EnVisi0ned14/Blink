//
//  ProfileController.swift
//  TinderClone
//
//  Created by Michael Abrams on 4/1/22.
//

import UIKit
import SDWebImage

public class StatsViewController: UIViewController {
    
    //MARK: - Properties
    
    private let user: User
    
    //private lazy var viewModel = ProfileViewModel(user: user)

    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blur)
        return view
    }()
    
    private let collectionView: StatsCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = StatsCollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private let dismissButton = ImageButton(image: #imageLiteral(resourceName: "RedX").withRenderingMode(.alwaysOriginal))

    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle targets
        dismissButton.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        
        //Configure UI
        configureUI()
        
    }
    
    //MARK: - Actions

    @objc private func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        //Set background to white
        view.backgroundColor = .white
        
        //Add subviews
        [collectionView, dismissButton, blurView].forEach({view.addSubview($0)})
        
        //Set collectionView frame
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        collectionView.constrainHeight(view.frame.width + 100)
        
        //Constrain dismiss button
        dismissButton.setDimensions(height: 90, width: 90)
        dismissButton.anchor(top: collectionView.bottomAnchor, right: view.trailingAnchor,
                             paddingTop: -45, paddingRight: 16)
        
        blurView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        

    }

    
}

//MARK: - UICollectionViewDataSource
extension StatsViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return viewModel.imageCount
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatsCollectionViewCell.identifier, for: indexPath) as! StatsCollectionViewCell
        
        //cell.imageView.sd_setImage(with: viewModel.imageURLs[indexPath.row])
        
        cell.imageView.sd_setImage(with: URL(string: user.userProfile.profilePictures.first!))

        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension StatsCollectionViewCell: UICollectionViewDelegate {
    
//    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        barStackView.setHighlighted(index: indexPath.row)
//    }
    
}

//MARK: - UICollectionViewFlowLayout
extension StatsViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width + 100)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
