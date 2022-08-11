//
//  RegistrationEmailViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit
import GTProgressBar



class RegistrationBirthDayViewController: UIViewController {

    //MARK: - Fields
    
    private var user: AuthCredentials
    
    private let progressBar = GTProgressBar.createBlinkProgressBar(progress: 4/8)
    
    private let birthdayLabel = RegistrationLabel(text: "Birthday?")
    
    private let continueButton = BlinkButton(title: "Continue")
    
    private let backButton = BackButton()
    
    private let birthDayTextField = BirthdayTextField()
    
    
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
        
        //Set delegates
        birthDayTextField.delegate = self
        
        //Add target
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    

    
    @objc private func continueTapped() {
        
        if let birthDay = birthDayTextField.getBirthday() {
            
            //If birthday is valid
            if(Validator.birthdayIsValid(for: birthDay)) {
                
                //Update user
                user.birthday = birthDay
                
                //Present next VC
                let genderVC = RegistrationGenderViewController(user: user)
                navigationController?.pushViewController(genderVC, animated: true)
                
            }
            else {
                birthDayTextField.shake()
            }
                
            
        }
        else {
            //Handle errors
            birthDayTextField.shake()
        }
        

        
    }
    

    //MARK: - Helpers

    private func presentNextController() {
        
    }
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        
        //Add all subviews
        [progressBar, birthdayLabel, continueButton, backButton].forEach({view.addSubview($0)})
        
        
        //Set constraints for progress bar
        progressBar.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 20)
        
        //Constrain the email label
        birthdayLabel.anchor(top: progressBar.bottomAnchor, paddingTop: 30)
        birthdayLabel.centerX(inView: view)
        
        //Constrain the back button
        backButton.anchor(top: progressBar.bottomAnchor, leading: progressBar.leadingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        
        view.addSubview(birthDayTextField)
        
        birthDayTextField.anchor(top: birthdayLabel.bottomAnchor, padding: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0))
        birthDayTextField.centerX(inView: view)
        //Present the keyboard
        birthDayTextField.presentKeyBoard()
        
        //Constrain the Continue button
        continueButton.anchor(top: birthDayTextField.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 20))
        
        
    }
    
}

//MARK: BirthdayTextFieldDelegate

extension RegistrationBirthDayViewController: BirthdayTextFieldDelegate {
    
    func birthDayTextFieldChanged(_ textField: BirthdayTile) {
        //If full, enable button else disable
        birthDayTextField.isFull() ? continueButton.enableContinueButton() : continueButton.disableContinueButton()
    }
    
}
