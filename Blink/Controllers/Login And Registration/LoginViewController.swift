//
//  LoginViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit

class LoginViewController: UIViewController {

    private let emailTextField = LoginTextField(placeHolder: "Email", isPassword: false)
    
    private let passwordTextField = LoginTextField(placeHolder: "Password", isPassword: false)
    
    private let loginButton: LoginButton = LoginButton()
    
    private let blinkLabel: BlinkLabel = BlinkLabel(blinkLabelType: .loginPage)

    private let noAccountLabel: NoAccountLabel = NoAccountLabel()
    
    private let signUpButton: SignUpButton = SignUpButton()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Configure the UI
        configureUI()
        
        //Set up delegates
        signUpButton.delegate = self
    }
    
    //Hide the navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Hide navigation bar
        navigationController?.navigationBar.isHidden = true
        
        //Hide tab bar
        tabBarController?.tabBar.isHidden = true
        
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        //Configure the gradient layer
        configureGradientLayer()
        
        //Create login stack view
        let loginStack = createLoginStackView()
        
        //Create registration stack view
        let registrationStack = createRegistrationStackView()
        
        //Add subivew
        view.addSubview(loginStack)
        view.addSubview(registrationStack)
        view.addSubview(blinkLabel)
        
        //Constrain stackView
        loginStack.centerY(inView: view)
        loginStack.centerX(inView: view)
        loginStack.anchor(left: view.leadingAnchor, right: view.trailingAnchor, paddingLeft: 20, paddingRight: 20)
        
        //Constrain blinkLabel
        blinkLabel.centerX(inView: view)
        blinkLabel.anchor(bottom: loginStack.topAnchor, paddingBottom: 40)
        
        //Constrain registrationStackView
        registrationStack.centerX(inView: view)
        registrationStack.anchor(top: loginStack.bottomAnchor, paddingTop: 5)
        
        
        
        
    }
    
    private func createLoginStackView() -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 15
        
        return stackView
        
    }
    
    private func createRegistrationStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [noAccountLabel, signUpButton])
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }
    


}

extension LoginViewController: SignUpButtonDelegate {
    
    func wantsToDisplayRegistrationController() {
        let registrationEmailVC = RegistrationEmailViewController()
        registrationEmailVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(registrationEmailVC, animated: true)
    }
    
}
