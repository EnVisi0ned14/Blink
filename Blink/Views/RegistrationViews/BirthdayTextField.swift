//
//  BirthdayTextField.swift
//  Blink
//
//  Created by Michael Abrams on 8/4/22.
//

import UIKit

enum BirthDayTile: String {
    case day = "D"
    case month = "M"
    case year = "Y"
}


protocol BirthdayTextFieldDelegate: AnyObject {
    func birthDayTextFieldChanged(_ textField: BirthdayTile)
}

class BirthdayTextField: UIStackView {

    //MARK: - Fields
    
    private let FIRST_SLASH_INDEX: Int = 2
    
    private let SECOND_SLASH_INDEX: Int = 4
    
    private let SPACING: CGFloat = 5
    
    private lazy var day1 = createBirthDayTile(for: .day)
    
    private lazy var day2 = createBirthDayTile(for: .day)
    
    private lazy var month1 = createBirthDayTile(for: .month)
    
    private lazy var month2 = createBirthDayTile(for: .month)
    
    private lazy var year1 = createBirthDayTile(for: .year)
    
    private lazy var year2 = createBirthDayTile(for: .year)
    
    private lazy var year3 = createBirthDayTile(for: .year)
    
    private lazy var year4 = createBirthDayTile(for: .year)
    
    private lazy var slash1 = createBirthDaySlash()
    
    private lazy var slash2 = createBirthDaySlash()
    
    private lazy var tiles = [month1, month2, day1, day2, year1, year2, year3, year4]
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    public weak var delegate: BirthdayTextFieldDelegate?
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureFields()
        
        configureUI()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc private func tileChanged(_ textField: BirthdayTile) {
        
        //Notify tile was changed
        delegate?.birthDayTextFieldChanged(textField)
        
        //Grab next tile
        let indexOfNextTile = min(tiles.count - 1, tiles.firstIndex(of: textField)! + 1)
        
        //Put as first responder
        tiles[indexOfNextTile].becomeFirstResponder()
        
    }
    
    
    //MARK: - Helpers
    
    /**
     Presents the inital starting point of the birthday text field
     */
    public func presentKeyBoard() {
        month1.becomeFirstResponder()
    }
    
    /**
    Checks if all text fields have input
     */
    public func isFull() -> Bool {
        
        //For loop over the tiles
        for tile in tiles {
            //If text is null return false
            guard let text = tile.text else { return false }
            
            //If text is empty return false
            if(text.isEmpty) {
                return false
            }
            
        }
        
        return true
        
    }
    
    /**
     Returns a date object, from the text field
     */
    public func getBirthday() -> Date? {
        
        //Create date string
        var dateString: String = ""
        
        //Append tiles so looks like MM/dd/yyyy
        for index in 0..<tiles.count {
            guard let text = tiles[index].text else { return nil }
            
            //If should add a slash
            if(index == FIRST_SLASH_INDEX || index == SECOND_SLASH_INDEX) {
                dateString.append("/")
            }
            
            //Append the text
            dateString.append(text)
        }
        
        //Return
        return dateFormatter.date(from: dateString)
        
        
    }
    
    private func configureFields() {
        
        //Set spacing
        spacing = SPACING
        
        //Equal distribution
        distribution = .fillProportionally
        
    }
    
    private func configureUI() {
        
        //Add all views to the stack view
        [month1, month2, slash1, day1, day2, slash2, year1, year2, year3, year4].forEach({addArrangedSubview($0)})
        
        
    }
    
    private func createBirthDayTile(for type: BirthDayTile) -> BirthdayTile {
        
        //Create birthday tile
        let tile = BirthdayTile(placeHolder: type.rawValue, lineColor: .systemGray4, placeHolderColor: #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1))
        
        //Set delegates
        tile.birthdayDelegate = self
        tile.delegate = self
        
        //Add target
        tile.addTarget(self, action: #selector(tileChanged), for: .editingChanged)
        
        //Return
        return tile
    }
    
    private func createBirthDaySlash() -> UILabel {
        //Create label
        let lbl = UILabel()
        //Add slash
        lbl.text = "/"
        //Change color
        lbl.textColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        //Update font
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        //Return
        return lbl
        
    }
    
    
}

//MARK: - BirthdayTileDelegate

extension BirthdayTextField: BirthdayTileDelegate {
    
    func deleteWasPressed(_ textField: BirthdayTile) {
        
        
        guard let text = textField.text else { return }
        
        //Grab next index of tile
        let indexOfNextTile = max(0, tiles.firstIndex(of: textField)! - 1)
        
        //If at the last text field, and has text in it
        if(textField == year4 && text.count == 1) {
            textField.text = ""
        }
        else {
            //Clear the text from the tile before
            tiles[indexOfNextTile].text = ""
            //Make first responder
            tiles[indexOfNextTile].becomeFirstResponder()
        }
        
        //Notify text field was changed
        delegate?.birthDayTextFieldChanged(textField)
        
    }
    
}


//MARK: - UITextFieldDelegate
extension BirthdayTextField: UITextFieldDelegate {
    
    //Limits text field to 1 character
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 1
        
    }
    
}



