//
//  ProfileTableViewCell.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

protocol ProfileTableViewCellDelegate: AnyObject {
    func settingsCell(_: UITableViewCell, wantsToUpdateUserWith value: String, for: ProfileSection)
}

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
    
    weak var delegate: ProfileTableViewCellDelegate?
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc private func handleUpdateUserInfo(_ textField: UITextField) {
        guard let value = textField.text else { return }
        delegate?.settingsCell(self, wantsToUpdateUserWith: value, for: profileViewModel.section)
    }

    
    //MARK: - Helpers
    
    //Called everytime a view model set
    private func configure() {
        
        //Set the place holder text for the input field
        inputField.placeholder = profileViewModel.placeHolderText
        
        //Assign the text for the input field
        inputField.text = profileViewModel.value
        
        //Sets the selection style to none
        selectionStyle = .none
        
        //Adds the input field
        contentView.addSubview(inputField)
        
        //Fill superview
        inputField.fillSuperview()
    }
    
    
    
    

}


