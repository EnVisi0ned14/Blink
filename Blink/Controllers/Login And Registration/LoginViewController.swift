//
//  LoginViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class LoginViewController: UIViewController {

    private let emailTextField = LoginTextField(placeHolder: "Email", isPassword: false)
    
    private let passwordTextField = LoginTextField(placeHolder: "Password", isPassword: true)
    
    private let loginButton: LoginButton = LoginButton()
    
    private let blinkLabel: BlinkLabel = BlinkLabel(blinkLabelType: .loginPage)

    private let noAccountLabel: NoAccountLabel = NoAccountLabel()
    
    private let signUpButton: SignUpButton = SignUpButton()
    
    private let hud = JGProgressHUD(style: .dark)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Configure the UI
        configureUI()
        
        //Set up delegates
        signUpButton.delegate = self
        
        //Add targets
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    //Hide the navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Hide navigation bar
        navigationController?.navigationBar.isHidden = true
        
        //Hide tab bar
        tabBarController?.tabBar.isHidden = true
        
    }
    
    //MARK: - Actions
    
    @objc private func loginTapped(_ loginButton: UIButton) {
        
        //Get email and password
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        //Show hud
        hud.show(in: view)
        
        //Sign in user with firebase auth
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            
            //Check for error
            guard error == nil else {
                self?.loginFailed(error: error!)
                return
            }
            
            //Get uid
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            //Fetch user
            Service.fetchUser(withUid: uid) { [weak self] user in
                //Log user in locally
                RegistrationManager.shared.logUserIn(user: user)
                
                //Remove hud
                self?.hud.dismiss()
                
                //Pop log in screen
                self?.navigationController?.popToRootViewController(animated: true)
            }
            
        }
        
    }
    
    private func loginFailed(error: Error) {
        
        //Remove hud
        hud.dismiss()
        
        //Shake both tiles
        emailTextField.shake()
        passwordTextField.shake()
        
        //Print error
        print("DEBUG: Error logging user in \(error.localizedDescription)")
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
        
        //Set hud text
        hud.textLabel.text = "Logging In"
        
        
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
