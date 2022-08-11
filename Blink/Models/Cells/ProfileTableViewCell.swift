//
//  ProfileTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    //MARK: - Fields
    
    public var profileViewModel: ProfileViewModel! {
        didSet {configure()}
    }
    
    lazy var inputField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 50, width: 28)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        tf.addTarget(self, action: #selector(handleUpdateUserInfo), for: .editingDidEnd)
        
        return tf
    }()
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Sets the selection style to none
        selectionStyle = .none
        
        //Adds the input field
        contentView.addSubview(inputField)
        inputField.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc private func handleUpdateUserInfo() {
        //TODO: API calls
    }
    
    //MARK: - Helpers
    
    //Called everytime a view model set
    private func configure() {
        //Set the place holder text for the input field
        inputField.placeholder = profileViewModel.placeHolderText
        //Assign the text for the input field
        inputField.text = profileViewModel.value
    }
    
    
    
    

}


