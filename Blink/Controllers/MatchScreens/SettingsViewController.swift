//
//  SettingsViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/2/22.
//

import UIKit
import JGProgressHUD
import FirebaseAuth

class SettingsViewController: UIViewController {

    private let user: User
    
    private let cells: [[SettingsSection]] = [
    [.accountSection(.distance),
     .accountSection(.age),
     .accountSection(.genderPreference),
     .accountSection(.genderSelection)],
    [.logoutSection(.logout)]]

    private let hud = JGProgressHUD(style: .dark)
    
    private let tableView = BlinkTableView(for: .settingsTableView)
    
    private let tableViewHeader: BlinkPlusTableViewHeader = BlinkPlusTableViewHeader()
    
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
    
        //Configure Navigation Bar
        configureNavigationBar()
        
        //Handle delegates
        tableViewHeader.delegate = self
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Configure the UI
        configureUI()
        
    }
    
    //MARK: - Actions
    
    @objc private func handleDone() {
    
        //Display hud
        hud.show(in: tableView)
        
        //Saver user data
        Service.saveUserData(for: user) { [weak self] error in
            
            //Remove hud
            self?.hud.dismiss()
            
            //Pop view controller
            self?.navigationController?.popViewController(animated: true)
            
            guard error == nil else {
                print("DEBUG: Failed to save user data")
                return
            }
            
        }
        
    }
    
    //MARK: - Helpers
    
    private func configureNavigationBar() {
        
        //Right bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        //Hide back button
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func configureUI() {
        //Add tableView
        view.addSubview(tableView)
        //Fill superview
        tableView.fillSuperview()
        //Set frame for header
        tableViewHeader.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        //Set the frame for footer
        tableView.tableFooterView = UIView()
        //Set header
        tableView.tableHeaderView = tableViewHeader
        
        //Set the background color
        view.backgroundColor = .white
        
        //Adds large titles
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Set the navigation title
        title = "Settings"
        
        //Set the hud title
        hud.textLabel.text = "Saving Changes"
        
    }
    
    private func handleLogout() {
        
        do {
            //Try to sign out
            try Auth.auth().signOut()
            
            //Pop view controller
            navigationController?.popViewController(animated: true)
            
            //Log user out
            RegistrationManager.shared.logUserOut()
            
            
        }
        catch (let error) {
            print("DEBUG: Error signing user out \(error.localizedDescription)")
        }
        
    }
    

}

//MARK: - TableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = cells[indexPath.section][indexPath.row]
        
        switch cell {
        case .accountSection(_):
            tableView.deselectRow(at: indexPath, animated: false)
        case .logoutSection(_):
            handleLogout()
        }
        
    }
    
}

//MARK: - TableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 0, width: 320, height: 20)
        myLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        myLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cells[section][0].titleForSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cells[indexPath.section][indexPath.row].cellHeight
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Grab cell model for section and row
        let cellModel = cells[indexPath.section][indexPath.row]

        //Create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier) as! PreferenceCellTableViewCell
        
        
        //Assign settings view model
        cell.settingsViewModel = SettingsViewModel(section: AccountSettingsSection(rawValue: indexPath.row)!, user: user)
      
        
        //Return cell
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cells[section][0].heightForHeader
    }
    
    

}


//MARK: - BlinkPLusTableViewHeaderDelegate

extension SettingsViewController: BlinkPlusTableViewHeaderDelegate {
    
    func blinkPlusTapped() {
        print("DEBUG: Blink plus tapped...")
    }
}


