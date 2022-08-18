//
//  ProfileViewController.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit
import JGProgressHUD



class ProfileViewController: UIViewController {
    
    //MARK: - Fields
    
    /** Section height is the height of each section*/
    private let SECTION_HEIGHT: CGFloat = 32
    
    private let user: User
    
    private lazy var newUserProfile = user.userProfile
    
    private lazy var profileHeaderView = ProfileHeaderView(user: user)
    
    private let hud = JGProgressHUD(style: .dark)
    
    private let tableView = BlinkTableView(for: .profileTableView)

    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Assign delegates
        tableView.delegate = self
        tableView.dataSource = self
        profileHeaderView.delegate = self
        
        //Configure Observers
        configureObservers()
        
        //Configure the UI
        configureUI()
        
        //Configure Navigation Bar
        configureNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    

    
    //MARK: - Actions
    
    @objc private func handleDone() {
        
        //Cancel editing
        view.endEditing(true)
        
        //Update user profile locally
        user.userProfile = newUserProfile
        
        //Show loading sign
        hud.show(in: view)
        
        Service.saveUserData(for: user) { [weak self] error in
            
            //Dismiss hud
            self?.hud.dismiss()
            
            //Check for error
            guard error == nil else {
                print("DEBUG: Error saving user data...")
                return
            }
            
            //Dismiss view
            self?.navigationController?.popViewController(animated: true)
            
        }
    }
    
    @objc private func handleCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    /**
        Handles updating tableView position to not cover text fields
     */
    @objc private func keyBoardWillShow(_ notification: NSNotification) {
        
        guard let info = notification.userInfo,
              let keyboardFrameRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
                else { return }
        
        let keyboardRect = keyboardFrameRect.cgRectValue
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRect.height, right: 0)
        tableView.contentInset = contentInset
        tableView.scrollIndicatorInsets = contentInset
        
    }
    
    //MARK: - Helpers
    
    private func configureNavigationBar() {
        //Left bar button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        //Right bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
    }
    
    private func configureObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    private func configureUI() {
        
        //Set background color
        view.backgroundColor = .white
        
        //Big title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Set the title for the navigation bar
        title = "Profile"
        
        //Add the tableView is a subView
        view.addSubview(tableView)
        
        hud.textLabel.text = "Uploading Data"
        
        //Fill Superview
        tableView.fillSuperview()
        
        //Set frame for the profileHeaderView
        profileHeaderView.frame = CGRect(x: 0,
                                         y: 0,
                                         width: view.frame.width,
                                         height: 0)
        profileHeaderView.frame.size.height = profileHeaderView.getHeight()
        
        //Assign the profileHeaderView
        tableView.tableHeaderView = profileHeaderView
        
        
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    
    //Assigns the number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileSection.allCases.count
    }
    
    //Height for each section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SECTION_HEIGHT
    }
    
    //Sets the title for each section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = ProfileSection(rawValue: section) else {return nil}
        return section.description
    }
    
    //Assigns one row per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    //Creates the cell for each section
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as! ProfileTableViewCell
        guard let section = ProfileSection(rawValue: indexPath.section) else { return cell }
        let viewModel = ProfileViewModel(section: section, user: user)
        cell.profileViewModel = viewModel
        cell.delegate = self
        return cell
    }
    
    
}

//MARK: - ProfileHeaderViewDelegate

extension ProfileViewController: ProfileHeaderViewDelegate {
    
    func wantsToUploadImage(button: ProfileImageButton) {
        
        ImagePickerManager().pickImage(self) { [weak self] image in
                
            guard let strongSelf = self else { return }
            
            //Upload photo to button
            button.uploadPhoto(with: image)
            
            //Display loading hud
            self?.hud.show(in: strongSelf.view)
            
            Service.uploadImage(image: image) { [weak self] profileUrl in
                
                guard let strongSelf = self else { return }
                
                //Update location
                self?.user.userProfile.profilePictures[button.tag] = profileUrl
                
                Service.saveUserData(for: strongSelf.user) { error in
                
                    //Dismiss hud
                    self?.hud.dismiss()
                    
                    guard error == nil else {
                        print("DEBUG: Error saving user data \(error!.localizedDescription)")
                        return
                    }
                    
                }
            }
        }
    }
}


extension ProfileViewController: ProfileTableViewCellDelegate {
    
    func settingsCell(_: UITableViewCell, wantsToUpdateUserWith value: String, for section: ProfileSection) {
        
        switch section {
        case .bio:
            newUserProfile.bio = value
        case .name:
            
            if(value.contains(" ")) {
                newUserProfile.firstName = String(value.split(separator: " ")[0])
                newUserProfile.lastName = String(value.split(separator: " ")[1])
            }

        case .school:
            newUserProfile.school = value
        case .profession:
            newUserProfile.occupation = value
        }
        
    }
}
