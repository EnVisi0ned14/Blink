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
    private let card: CardView = CardView(frame: .zero)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try FirebaseAuth.Auth.auth().signOut()
        }
        catch {
        
        }
        
        //Assign delegates
        matchScreenTopStackView.delegate = self
        
        //Create observers
        createObservers()
        
        //Check if user is logged in
        checkIfUserIsLoggedIn()
        
        //Configure the UI
        configureUI()
        
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hides the navigation bar
        navigationController?.navigationBar.isHidden = true
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
        
    }
    
    @objc private func userLoggedIn(notification: NSNotification) {
        
        guard let user = RegistrationManager.shared.getCurrentUser() else { return }
        
        fetchAndLoadCards(for: user)
        
    }
    
    private func fetchAndLoadCards(for user: User) {
        
        
        
    }
    
    private func checkIfUserIsLoggedIn() {
        
        //If there is not a current user
        if(FirebaseAuth.Auth.auth().currentUser == nil) {
            presentLoginController()
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
        
        
        //Add the top stack view as a subivew
        view.addSubview(matchScreenTopStackView)
        
        //Constrain the top stack view
        matchScreenTopStackView.anchor(top: view.topAnchor,
                                       leading: view.leadingAnchor,
                                       trailing: view.trailingAnchor)
        
        //Add the card to the subview
        view.addSubview(card)
        
        //Constrain the card
        card.anchor(top: matchScreenTopStackView.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20))
        
        
    }
}

//MARK: - MatchScreenTopStackViewDelegate
extension MatchScreenViewController: MatchScreenTopStackViewDelegate {
    
    //Present profile controller
    func wantsToPresentProfileController() {

        //Create the profile VC
        let profileVC = ProfileViewController()
        //Present full screen
        profileVC.modalPresentationStyle = .fullScreen
        //Set the title
        profileVC.title = "Profile"
        //Present
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func wantsToPresentSettingsController() {
        
        let settingsVC = SettingsViewController()
        
        settingsVC.modalPresentationStyle = .fullScreen
        
        settingsVC.title = "Settings"
        
        navigationController?.pushViewController(settingsVC, animated: true)
        
    }
    
}
