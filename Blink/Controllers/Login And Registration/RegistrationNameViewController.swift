//
//  RegistrationEmailViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit
import GTProgressBar


enum NameType {
    case firstName
    case lastName
}

class RegistrationNameViewController: UIViewController {

    //MARK: - Fields
    
    public var user: AuthCredentials
    
    private let progressBar = GTProgressBar.createBlinkProgressBar(progress: 3/8)
    
    private let firstNameTextField = SingleLineTextField(placeHolder: "First name", type: .name)
    
    private let lastNameTextField = SingleLineTextField(placeHolder: "Last name", type: .name)

    private let nameLabel = RegistrationLabel(text: "Name?")
    
    private let continueButton = BlinkButton(title: "Continue")
    
    private let backButton = BackButton()
    
    //MARK: - Lifecycle
    
    init(user: AuthCredentials) {
        self.user = user
        
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
        firstNameTextField.addTarget(self, action: #selector(firstNameUpdated), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(lastNameUpdated), for: .editingChanged)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
    }
    
    //MARK: - Actions
    
    @objc private func lastNameUpdated(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        handleNameChanged(with: text, for: .lastName)
        
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func firstNameUpdated(_ textField: UITextField) {

        guard let text = textField.text else { return }
        
        handleNameChanged(with: text, for: .firstName)
        
    }
    
    @objc private func continueTapped() {
        let birthVC = RegistrationBirthDayViewController(user: user)
        navigationController?.pushViewController(birthVC, animated: true)
    }
    

    //MARK: - Helpers
    
    private func handleNameChanged(with text: String, for type: NameType) {
        
        //Update the user fields
        updateUser(with: text, for: type)
        

        //If both names are valid
        if(Validator.firstNameIsValid(for: firstNameTextField.text) &&
            Validator.lastNameIsValid(for: lastNameTextField.text)) {
            
            //Enable continue button
            continueButton.enableContinueButton()
            
        }
        else {
            //Disable button
            continueButton.disableContinueButton()
        }
        

        
    }
    
    private func updateUser(with text: String, for type: NameType) {
        
        switch type {
        case .firstName:
            user.firstName = text
        case .lastName:
            user.lastName = text
        }
        
    }

    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        //Set constraints on text fields
        firstNameTextField.constrainHeight(30)
        lastNameTextField.constrainHeight(30)
        
        //Add all subviews
        [progressBar, nameLabel, firstNameTextField, lastNameTextField, continueButton, backButton].forEach({view.addSubview($0)})
        
        
        //Set constraints for progress bar
        progressBar.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 20)
        
        //Constrain the email label
        nameLabel.anchor(top: progressBar.bottomAnchor, paddingTop: 30)
        nameLabel.centerX(inView: view)
        
        //Constrain the back button
        backButton.anchor(top: progressBar.bottomAnchor, leading: progressBar.leadingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        
        let nameStackView = createNameStackView()
        
        view.addSubview(nameStackView)
        
        nameStackView.anchor(top: nameLabel.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 100, left: 50, bottom: 0, right: 50))
        
        //Constrain the Continue button
        continueButton.anchor(top: nameStackView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 20))
        
        
        
    }
    
    private func createNameStackView() -> UIStackView {
        
        //Create stack view
        let nameStackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField])
        //Fill equally
        nameStackView.distribution = .fillEqually
        //Add spacing
        nameStackView.spacing = 20
        //Vertical axis
        nameStackView.axis = .vertical
        //Return
        return nameStackView
    }

}
