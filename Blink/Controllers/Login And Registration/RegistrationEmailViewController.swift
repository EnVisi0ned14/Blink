//
//  RegistrationEmailViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit
import GTProgressBar


class RegistrationEmailViewController: UIViewController {

    //MARK: - Fields
    
    private var user = AuthCredentials()
    
    private let progressBar = GTProgressBar.createBlinkProgressBar(progress: 1/8)
    
    private let emailTextField = SingleLineTextField(placeHolder: "Email", type: .email)

    private let emailLabel = RegistrationLabel(text: "Email?")
    
    private let continueButton = BlinkButton(title: "Continue")
    
    private let backButton = BackButton()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Configure the UI
        configureUI()
        
        //Add target
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(emailUpdated), for: .editingChanged)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        emailTextField.setBottomLine(borderColor: .black)
    }
    
    //MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func emailUpdated(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        handleEmailChanged(with: text)
        
    }
    
    @objc private func continueTapped() {
        //TODO: Check if email is already in use
        let passwordVC = RegistrationPassowordViewController(user: user)
        navigationController?.pushViewController(passwordVC, animated: true)
    }
    

    //MARK: - Helpers
    
    private func handleEmailChanged(with text: String) {
        
        //If email is valid
        if(Validator.emailIsValid(for: text)) {
            
            //Enable continue button
            continueButton.enableContinueButton()
        }
        else {
            //Disable continue button
            continueButton.disableContinueButton()
        }
        
        //Update user email
        user.email = text
        
    }
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        //Add all subviews
        [progressBar, emailLabel, emailTextField, continueButton, backButton].forEach({view.addSubview($0)})
        
        
        //Set constraints for progress bar
        progressBar.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 20)
        
        //Constrain the email label
        emailLabel.anchor(top: progressBar.bottomAnchor, paddingTop: 30)
        emailLabel.centerX(inView: view)
        
        //Constrain the back button
        backButton.anchor(top: progressBar.bottomAnchor, leading: progressBar.leadingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        
        //Constrain the email text field
        emailTextField.anchor(top: emailLabel.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 100, left: 50, bottom: 0, right: 50))
        emailTextField.constrainHeight(30)
        
        //Constrain the Continue button
        continueButton.anchor(top: emailTextField.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 20))
        
        
        
    }

}
