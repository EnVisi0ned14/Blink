//
//  SettingsViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/2/22.
//

import UIKit


class SettingsViewController: UIViewController {

    private let SECTION_COUNT: Int = 1
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingsSliderTableViewCell.self,
                           forCellReuseIdentifier: SettingsSliderTableViewCell.identifier)
        tableView.register(SettingsGenderTableViewCell.self,
                           forCellReuseIdentifier: SettingsGenderTableViewCell.identifier)
        tableView.backgroundColor = #colorLiteral(red: 0.9567686915, green: 0.9569286704, blue: 0.9567475915, alpha: 1)
        return tableView
    }()
    
    private let tableViewHeader: BlinkPlusTableViewHeader = BlinkPlusTableViewHeader()
    
    private let tableViewFooter: LogoutTableViewFooter = LogoutTableViewFooter()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure the UI
        configureUI()
        
        //Handle delegates
        tableViewHeader.delegate = self
        tableViewFooter.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        

        
    }
    
    //MARK: - Helpers
    private func configureUI() {
        //Add tableView
        view.addSubview(tableView)
        //Fill superview
        tableView.fillSuperview()
        //Set frame for header
        tableViewHeader.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        //Set frame for footer
        tableViewFooter.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        //Set header
        tableView.tableHeaderView = tableViewHeader
        //Set footer
        tableView.tableFooterView = tableViewFooter
        
        //Set the background color
        view.backgroundColor = .white
        
        //Adds large titles
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Set the navigation title
        title = "Settings"
        
        
    }
    

}


//MARK: - TableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    
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
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SECTION_COUNT
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Account Settings"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let cell = SettingSection(rawValue: indexPath.row) else { return 0 }
        
        return cell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let settingsCell = SettingSection(rawValue: indexPath.row) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: settingsCell.identifier) as! PreferenceCellTableViewCell
        cell.settingsViewModel = SettingsViewModel(section: settingsCell,
                                                   user: User(with: AuthCredentials(
                                                                email: "",
                                                                firstName: "",
                                                                lastName: "",
                                                                password: "",
                                                                birthday: Date(),
                                                                gender: .male,
                                                                preference: .female,
                                                                profilePicutre: UIImage(named: "plus")!,
                                                                location: Location(longitude: 0, latitude: 0, geoHash: "")), profileDownloadUrl: [],
                                                              uid: "")!)

        return cell

    }
    
    
}


//MARK: - BlinkPLusTableViewHeaderDelegate

extension SettingsViewController: BlinkPlusTableViewHeaderDelegate {
    
    func blinkPlusTapped() {
        print("DEBUG: Blink plus tapped...")
    }
}

//MARK: - LogoutTableViewFooterDelegate

extension SettingsViewController: LogoutTableViewFooterDelegate {
    
    func wantsToLogout() {
        print("DEBUG: Logout tapped...")
    }
    
    
}
