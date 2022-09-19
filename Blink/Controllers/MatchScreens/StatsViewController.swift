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
    
    /** tableView is the tableview for the user's stats */
    private let tableView: StatsTableView = StatsTableView(frame: .zero, style: .grouped)
    
    private lazy var statsHeader: StatsHeaderView = StatsHeaderView(userProfile: user.userProfile)
    
    private let dismissButton = ImageButton(image: #imageLiteral(resourceName: "RedX").withRenderingMode(.alwaysOriginal))
    
    /** cells are the cells for the table view */
    private let cells: [[StatsTableSection]] = [
        [.statSection(.ghosted),
         .statSection(.talkingTo),
         .statSection(.swipeRight),
         .statSection(.swipeLeft)],
        [.aboutSection(.aboutMe)],
        [.infoSection(.occupation),
         .infoSection(.gender),
         .infoSection(.distance),
         .infoSection(.school)],
        [.reportSection(.report)]
    ]

    
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
        
        //Set the delegates
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        //Configure UI
        configureUI()

        
    }
    
    //MARK: - Actions

    @objc private func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
    
    private func reportUser() {
        print("DEBUG: Report user \(user.userProfile.firstName)")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        //Set background to white
        view.backgroundColor = .white
        
        //Add subviews
        [collectionView, tableView, dismissButton, blurView].forEach({view.addSubview($0)})
        
        //Add headerView for the tableView
        statsHeader.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: StatsHeaderView.height)
        tableView.tableHeaderView = statsHeader
        
        //Set collectionView frame
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        collectionView.constrainHeight(view.frame.width + 100)
        
        //Constrain dismiss button
        dismissButton.setDimensions(height: 90, width: 90)
        dismissButton.anchor(top: collectionView.bottomAnchor, right: view.trailingAnchor,
                             paddingTop: -45, paddingRight: 16)
        
        //Constrain blur view
        blurView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        
        //Constrain the tableView
        tableView.anchor(top: collectionView.bottomAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor)
        
        

    }

    
}

//MARK: - UICollectionViewDataSource
extension StatsViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.userProfile.pictureCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatsCollectionViewCell.identifier, for: indexPath) as! StatsCollectionViewCell
        
        
        guard let imageUrl = URL(string: user.userProfile.profilePictures[indexPath.row]) else {
            print("DEBUG: Failed to create url \(user.userProfile.profilePictures[indexPath.row])")
            return UICollectionViewCell()
        }
        
        cell.imageView.sd_setImage(with: imageUrl)

        return cell
    }
    
    
}


//MARK: - UICollectionViewDelegate
extension StatsCollectionView: UICollectionViewDelegate {
    
    
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


//MARK: - UITableViewDelegate
extension StatsViewController: UITableViewDelegate {
    
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 15, y: 0, width: 320, height: 50)
        myLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        myLabel.textColor = #colorLiteral(red: 0.2392156863, green: 0.231372549, blue: 0.231372549, alpha: 1)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cells[indexPath.section][indexPath.row].identifier,
                                                 for: indexPath) as! AbstractStatsTableViewCell
        
        //Assign the view model
        cell.viewModel = StatViewModel(section: cells[indexPath.section][indexPath.row], user: user)
        
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cells[indexPath.section][indexPath.row].cellHeight
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cells[section][0].headerTitle
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cells[section][0].heightForHeader
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = cells[indexPath.section][indexPath.row]
        
        switch cell {
        case .reportSection(_):
            reportUser()
        default:
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        //Grab the height for the footer
        let height = cells[section][0].heightForFooter
        
        let contentView = UIView()
        let line = UIView()
        contentView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        contentView.addSubview(line)
        line.anchor(left: contentView.leadingAnchor, bottom: contentView.bottomAnchor, right: contentView.trailingAnchor)
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true
        line.backgroundColor = .systemGray3
        return contentView
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return cells[section][0].heightForFooter
    }
}

//MARK: - UITableViewDatasource

extension StatsViewController: UITableViewDataSource {
    

    
}
