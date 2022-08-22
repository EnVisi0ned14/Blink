//
//  ConversationViewController.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

class ConversationViewController: UIViewController {
    
    //MARK: - Fields
    
    private let blinkTopStack = MatchScreenTopStackView()
    
    private let converstationTableView = BlinkTableView(for: .conversationTableView)
    
    private let cells: [ConversationCellItem] = [MatchSection(), ConversationSection()]
    
    private var matches: [Match] = [Match]() {
        didSet { converstationTableView.reloadData() }
    }
    
    private var conversations: [Conversation] = [Conversation]() {
        didSet { converstationTableView.reloadData() }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegates
        converstationTableView.delegate = self
        converstationTableView.dataSource = self

        //Configure the UI
        configureUI()
        
 
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Hide navigation bar
        navigationController?.navigationBar.isHidden = true
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        //Create observers
        createObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    //MARK: - Action
    
    @objc private func userLoggedIn(notification: NSNotification) {
        
        Service.getMatchesForUser { matches in
            self.matches = matches
        }
        
        Service.getConversationsForUser { conversations in
            self.conversations = conversations
        }
    }
    
    
    
    //MARK: - Helpers
    
    private func createObservers() {
        
        //Log in observer
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userLoggedIn(notification:)),
                                               name: Notification.Name(USER_LOGGED_IN),
                                               object: nil)
        
    }
    
    private func configureUI() {
        
        //Set background color
        view.backgroundColor = .white
        
        //Add subviews
        [blinkTopStack, converstationTableView].forEach({view.addSubview($0)})
        
        //Constrain the top stack
        blinkTopStack.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        blinkTopStack.hideSettingsAndProfile()
        
        //Constrain the table view
        converstationTableView.anchor(top: blinkTopStack.bottomAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingTop: 15, paddingLeft: 15)
        
        
        
    }

}


//MARK: - TableViewDelegate

extension ConversationViewController: UITableViewDelegate {
   
}

//MARK: - TableViewDatasource

extension ConversationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let cells = cells[section] as? MatchSection {
            return cells.titleForSection
        }
        else if let cells = cells[section] as? ConversationSection {
            return cells.titleForSection
        }
        else {
            fatalError()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if cells[section] is MatchSection {
            return 1
        }
        else if cells[section] is ConversationSection {
            return conversations.count
        }
        else {
            fatalError()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let cells = cells[indexPath.section] as? MatchSection {
            return cells.cellHeight
        }
        else if let cells = cells[indexPath.section] as? ConversationSection {
            return cells.cellHeight
        }
        else {
            fatalError()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = cells[indexPath.section] as? MatchSection {
            let cell = tableView.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.matches = matches
            cell.delegate = self
            return cell
        }
        else if let cell = cells[indexPath.section] as? ConversationSection {
            let cell = tableView.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! ConversationTableViewCell
            cell.conversation = conversations[indexPath.row]
            return cell
        }
        else {
            fatalError()
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 0, y: 0, width: 320, height: 20)
        myLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        myLabel.textColor = #colorLiteral(red: 1, green: 0.6862745098, blue: 0.2588235294, alpha: 1)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }
    
}

extension ConversationViewController: CollectionTableViewCellDelegate {
    
    func wantsToBeginConversation(for user: User) {
        //Create chat view controller
        guard let chatVC = ChatViewController(recieveUser: user) else { return }
        //Push the view controller
        navigationController?.pushViewController(chatVC, animated: true)
    }
}
