//
//  MatchScreenViewController.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit
import FirebaseAuth

class MatchScreenViewController: UIViewController {

    //MARK: - Fields
    private let matchScreenTopStackView = MatchScreenTopStackView(frame: .zero)

    private var topCardView: CardView?
    private var cardViews = [CardView]()
    
    private var viewModels = [CardViewModel]() {
        didSet { configureCards() }
    }
    
    private let deckView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign delegates
        matchScreenTopStackView.delegate = self
        
        //Create observers
        createObservers()
        
        //Check if user is logged in
        handleLogIn()
        
        //Configure the UI
        configureUI()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hides the navigation bar
        navigationController?.navigationBar.isHidden = true
        //Hide tab bar
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    
    //MARK: - Helper
    
    private func createObservers() {
        
        //Log in observers
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(MatchScreenViewController.userLoggedIn(notification:)),
            name: Notification.Name(USER_LOGGED_IN),
            object: nil)
        
        //Logout observers
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleLogout),
            name: Notification.Name(USER_LOGGED_OUT),
            object: nil)
        
    }
    
    @objc private func userLoggedIn(notification: NSNotification) {
        
        guard let user = RegistrationManager.shared.getCurrentUser() else { return }
        guard let profileUrl = URL(string: user.userProfile.profilePictures[0]) else { return }
        
        print("DEBUG: Fetching and loading cards")
        
        //Update profile picture
        //matchScreenTopStackView.setProfilePicture(with: profileUrl)
        
        //Fetch and load cards
        //fetchAndLoadCards(for: user)
        
    }
    
    private func fetchAndLoadCards(for user: User) {

        Service.fetchUsers(for: user) { [weak self] users in
            
            self?.viewModels = users.map({ user in
                print("DEBUG: Fetched user \(user.userProfile.firstName)")
                return CardViewModel(user: user)
            })
        }
        
    }
    
    private func handleLogIn() {
        
        //If there is not a current user
        if(FirebaseAuth.Auth.auth().currentUser == nil) {
            presentLoginController()
            return
        }
        else {
            logUserIn()
        }
        
        
    }
    
    private func logUserIn() {
        print("DEBUG: Logging user in")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Service.fetchUser(withUid: uid) { user in
            print("DEBUG: Found user logging in...")
            RegistrationManager.shared.logUserIn(user: user)
        }
        
        
        
    }
    
    private func presentLoginController() {
        //Create login VC
        let loginVC = LoginViewController()
        
        //Full screen
        loginVC.modalPresentationStyle = .fullScreen
        
        //Push controller
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    private func configureUI() {
        //Make background color white
        view.backgroundColor = .white
        
        //Create stack
        let cardStack = createCardStack()
        
        //Add card stack to superview
        view.addSubview(cardStack)
        
        //Constrain card stack
        cardStack.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.trailingAnchor,
                         padding: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20))
        
    }
    
    private func createCardStack() -> UIStackView {
        //Create card stack
        let cardStack = UIStackView(arrangedSubviews: [matchScreenTopStackView, deckView])
        //Axis vertical
        cardStack.axis = .vertical
        //Fill
        cardStack.distribution = .fill
        //Spacing
        cardStack.spacing = 10
        //Return
        return cardStack
    }
    
    
    private func configureCards() {
        print("DEBUG: Configuring cards...")
        
        viewModels.forEach { viewModel in
            let cardView = CardView(cardViewModel: viewModel)
            cardView.delegate = self
            deckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        
        cardViews = deckView.subviews.map({ $0 as! CardView })
        topCardView = cardViews.last
        
    }
    
    private func presentMatchView(matchViewModel: MatchViewModel) {
        
        //Hide tab bar
        tabBarController?.tabBar.isHidden = true
        //Create match view
        let matchView = MatchScreenView(viewModel: matchViewModel)
        //Add as subview
        view.addSubview(matchView)
        //Fill superview
        matchView.fillSuperview()
    }
    
    private func saveSwipeAndCheckForMatch(forUser user: User, didLike: Bool) {
        
        Service.saveSwipe(forUser: user, isLike: didLike) { error in
            self.topCardView = self.cardViews.last

            guard didLike == true else { return }

            Service.checkIfMatchExists(forUser: user) { didMatch in
                guard didMatch else { return }
                guard let currentUser = RegistrationManager.shared.getCurrentUser() else { return }
 
                //Present match view
                self.presentMatchView(matchViewModel: MatchViewModel(currentUser: currentUser, otherUser: user))
                
                //Upload match to database
                Service.uploadMatch(currentUser: currentUser, matchedUser: user)
            }
        }
    }
    
    @objc private func handleLogout() {
    
        //Remove card views
        cardViews = []
        
        //Remove Cards
        deckView.subviews.forEach({$0.removeFromSuperview()})
        
        //Present login controller
        presentLoginController()
    }
    
}

//MARK: - MatchScreenTopStackViewDelegate
extension MatchScreenViewController: MatchScreenTopStackViewDelegate {
    
    //Present profile controller
    func wantsToPresentProfileController() {
        
        //Get the current user
        guard let user = RegistrationManager.shared.getCurrentUser() else { return }

        //Create the profile VC
        let profileVC = ProfileViewController(user: user)
        //Present full screen
        profileVC.modalPresentationStyle = .fullScreen
        //Set the title
        profileVC.title = "Profile"
        //Present
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func wantsToPresentSettingsController() {
        
        guard let user = RegistrationManager.shared.getCurrentUser() else { return }
        
        let settingsVC = SettingsViewController(user: user)
        
        settingsVC.modalPresentationStyle = .fullScreen
        
        settingsVC.title = "Settings"
        
        navigationController?.pushViewController(settingsVC, animated: true)
        
    }
    
    
    
}

//MARK: CardViewDelegate

extension MatchScreenViewController: CardViewDelegate {
    
    func cardView(_ view: CardView, wantsToShowStatsFor user: User) {
        
        let statsVC = StatsViewController(user: user)
        
        statsVC.modalPresentationStyle = .fullScreen
        
        present(statsVC, animated: true, completion: nil)

    }
    
    func cardView(_ view: CardView, didLikeUser: Bool) {
        
        print("DEBUG: Swipe detected...")
        view.removeFromSuperview()
        self.cardViews.removeAll(where: { view == $0})
        
        guard let user = topCardView?.cardViewModel.user else { return }
        self.saveSwipeAndCheckForMatch(forUser: user, didLike: didLikeUser)
        
        self.topCardView = cardViews.last
    }
    
    
}


