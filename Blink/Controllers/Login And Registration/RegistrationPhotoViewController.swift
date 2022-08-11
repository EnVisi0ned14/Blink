//
//  RegistrationEmailViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit
import GTProgressBar
import JGProgressHUD

class RegistrationPhotoViewController: UIViewController {

    //MARK: - Fields
    
    private var credentials: AuthCredentials
    
    private let progressBar = GTProgressBar.createBlinkProgressBar(progress: 7/8)
    
    private let hud = JGProgressHUD(style: .dark)
    
    private let choosePhotoLabel: RegistrationLabel = {
        let lbl = RegistrationLabel(text: "Choose\nA Photo.")
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private let profileButton = ProfileImageButton()
    
    private let finishButton = BlinkButton(title: "Finish")
    
    private let backButton = BackButton()
    
    
    //MARK: - Lifecycle
    
    init(user: AuthCredentials) {
        self.credentials = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        //Add target
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        finishButton.addTarget(self, action: #selector(finishTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        
        
    }
    
    //MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    

    @objc private func finishTapped() {
        
        userHasEnabledLocation { [weak self] success in
            
            //If user has enabled location
            if(success) {
                
                self?.registerUser()
            }
            else {
                print("DEBUG: User has not enabled location...")
            }
            
        }
        
    }
    
    private func registerUser() {
        
        //Show spinner
        hud.show(in: view)
        
        //Register User
        RegistrationManager.shared.registerUser(withCredentials: credentials) { [weak self] result in
            
            switch result {
            case .success(let user):
                print("DEBUG: Registered user success...")
                self?.userWasRegistered(user)
                
            case .failure(let error):
                
                //Dismiss spinner
                self?.hud.dismiss()
                
                //Print Error
                print("DEBUG: Error when registering user: \(error.localizedDescription)")
                
            }
            
        }
    }
    
    private func userHasEnabledLocation(completion: @escaping (Bool) -> Void) {
        
        LocationManager.shared.getCurrentLocation { [weak self] result in
            
            switch result {
            case .success(let location):
                
                //Update credentials location
                self?.credentials.location = location
                
                //Return success
                completion(true)
                
                break
            case .failure(let error):
                print("DEBUG: Failed to get location \(error.localizedDescription)")
                completion(false)
                break
            }
            
        }
        
    }
    
    private func userWasRegistered(_ user: User) {
        
        //Log the user in
        RegistrationManager.shared.logUserIn(user: user)
        
        //Notify observers that user logged in
        NotificationCenter.default.post(name: Notification.Name(rawValue: USER_LOGGED_IN),
                                        object: nil)
        
        //Dismiss spinner
        hud.dismiss()
        
        //Present home screen
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    @objc private func profileTapped(profileButton: ProfileImageButton) {
        
        //Present the image picker
        ImagePickerManager().pickImage(self) { [weak self] image in
            //Upload the photo
            profileButton.uploadPhoto(with: image)
            //Update user
            self?.credentials.profilePicutre = image
            //Enable button
            self?.finishButton.enableContinueButton()
        }
        
        
        
    }
    

    //MARK: - Helpers

    private func configureUI() {
        
        //Give the hud a text label
        hud.textLabel.text = "Creating Account"

        //Set background color
        view.backgroundColor = .white
        
        //Add all subviews
        [progressBar, choosePhotoLabel, finishButton, backButton, profileButton].forEach({view.addSubview($0)})
        
        //Set constraints for progress bar
        progressBar.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 20)
        
        //Constrain the back button
        backButton.anchor(top: progressBar.bottomAnchor, leading: progressBar.leadingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        
        //Constrain the preference label
        choosePhotoLabel.anchor(top: progressBar.bottomAnchor, left: backButton.trailingAnchor, paddingTop: 30, paddingLeft: 15)
        
        
        //Constrain profileButton
        profileButton.anchor(size: CGSize(width: view.frame.width - 40, height: view.frame.width - 40))
        profileButton.centerInSuperview()
        
        //Constrain the Continue button
        finishButton.anchor(leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 50, right: 20))
        
    }
    
    
}
