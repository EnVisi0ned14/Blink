//
//  RegistrationEmailViewController.swift
//  Blink
//
//  Created by Michael Abrams on 8/3/22.
//

import UIKit
import GTProgressBar

class RegistrationGenderViewController: UIViewController {

    //MARK: - Fields
    
    private var user: AuthCredentials
    
    private let progressBar = GTProgressBar.createBlinkProgressBar(progress: 5/8)
    
    private let genderLabel: RegistrationLabel = {
        let lbl = RegistrationLabel(text: "What's Your\nGender?")
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private let continueButton = BlinkButton(title: "Continue")
    
    private let femaleSelectButton = SelectButton(title: "Female")
    
    private let maleSelectButton = SelectButton(title: "Male")
    
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
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        maleSelectButton.addTarget(self, action: #selector(maleSelected), for: .touchUpInside)
        femaleSelectButton.addTarget(self, action: #selector(femaleSelected), for: .touchUpInside)
        
        
    }
    
    //MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func maleSelected(maleButton: SelectButton) {
        
        //If female button is selected
        if(femaleSelectButton.isSelected()) {
            femaleSelectButton.deselect()
        }
        
        //Select male button
        maleButton.select()
        
        //Update user gender
        user.gender = .male
        
        //Enable continue button
        continueButton.enableContinueButton()
        
    }
    
    @objc private func femaleSelected(femaleButton: SelectButton) {
        
        //If male button is selected
        if(maleSelectButton.isSelected()) {
            maleSelectButton.deselect()
        }
        
        //Select female button
        femaleButton.select()
        
        //Update user gender
        user.gender = .female
        
        //Enable continue button
        continueButton.enableContinueButton()
        
    }
    

    @objc private func continueTapped() {
        let preferenceVC = RegistrationPreferenceViewController(user: user)
        navigationController?.pushViewController(preferenceVC, animated: true)
    }
    

    //MARK: - Helpers

    private func presentNextController() {
        
    }
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        
        //Add all subviews
        [progressBar, genderLabel, continueButton, backButton].forEach({view.addSubview($0)})
        
        
        //Set constraints for progress bar
        progressBar.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 20)
        
        //Constrain the back button
        backButton.anchor(top: progressBar.bottomAnchor, leading: progressBar.leadingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        
        //Constrain the gender label
        genderLabel.anchor(top: progressBar.bottomAnchor, left: backButton.trailingAnchor, paddingTop: 30, paddingLeft: 15)
        
        
        //Create gender stack view
        let genderStack = createGenderStackView()
        
        //Add subview
        view.addSubview(genderStack)
        
        //Constrain stack view
        genderStack.anchor(top: genderLabel.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 20))
        
        
        //Constrain the Continue button
        continueButton.anchor(leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 50, right: 20))
        
    }
    
    private func createGenderStackView() -> UIStackView {
        
        let stack = UIStackView(arrangedSubviews: [femaleSelectButton, maleSelectButton])
        
        //Set the axis
        stack.axis = .vertical
        
        //Set spacing
        stack.spacing = 20
        
        //Set distribution
        stack.distribution = .fillEqually
        
        return stack
        
    }
    
}
