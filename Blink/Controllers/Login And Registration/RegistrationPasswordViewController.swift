//
//  RegistrationEmailViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit
import GTProgressBar


class RegistrationPassowordViewController: UIViewController {

    //MARK: - Fields
    
    public var user: AuthCredentials
    
    private let progressBar = GTProgressBar.createBlinkProgressBar(progress: 2/8)
    
    private let passwordTextField = SingleLineTextField(placeHolder: "Password", type: .password)

    private let passwordLabel = RegistrationLabel(text: "Password?")
    
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
        passwordTextField.addTarget(self, action: #selector(passwordUpdated), for: .editingChanged)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        passwordTextField.setBottomLine(borderColor: .black)
    }
    
    //MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func passwordUpdated(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        handlePasswordChanged(with: text)
        
    }
    
    @objc private func continueTapped() {
        let nameVC = RegistrationNameViewController(user: user)
        navigationController?.pushViewController(nameVC, animated: true)
    }
    

    //MARK: - Helpers
    
    private func handlePasswordChanged(with text: String) {
        
        if(Validator.passwordIsValid(for: text)) {
            
            //Enable continue button
            continueButton.enableContinueButton()
            
        }
        else {
            continueButton.disableContinueButton()
        }
        
        user.password = text
        
    }
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        //Add all subviews
        [progressBar, passwordLabel, passwordTextField, continueButton, backButton].forEach({view.addSubview($0)})
        
        
        //Set constraints for progress bar
        progressBar.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 20)
        
        //Constrain the email label
        passwordLabel.anchor(top: progressBar.bottomAnchor, paddingTop: 30)
        passwordLabel.centerX(inView: view)
        
        //Constrain the back button
        backButton.anchor(top: progressBar.bottomAnchor, leading: progressBar.leadingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        
        //Constrain the email text field
        passwordTextField.anchor(top: passwordLabel.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 100, left: 50, bottom: 0, right: 50))
        passwordTextField.constrainHeight(30)
        
        //Constrain the Continue button
        continueButton.anchor(top: passwordTextField.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 20))
        
        
        
    }

}
