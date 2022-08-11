//
//  ProfileHeaderView.swift
//  Blink
//
//  Created by Michael Abrams on 8/2/22.
//

import UIKit

class ProfileHeaderView: UIView {
    

    
    /** NUMBER_OF_COLUMNS is the number of columns in the profile header view*/
    private let NUMBER_OF_COLUMNS: CGFloat = 3
    
    /** TOTAL_WIDTH_PADDING is the total padding on the left + right  + in between columns */
    private let TOTAL_WIDTH_PADDING: CGFloat = 60
    
    /** TOTAL_HEIGHT_PADDING is the total padding on the top + bottom + in between columns */
    private let TOTAL_HEIGHT_PADDING: CGFloat = 40
    
    private var regularProfileButtonWidth: CGFloat {
        
        get {
            return (frame.width - TOTAL_WIDTH_PADDING) / NUMBER_OF_COLUMNS
        }
        
    }
    
    private let bigProfileButton: ProfileImageButton = ProfileImageButton(image: nil, index: 0)
    private let regularProfileButton1: ProfileImageButton = ProfileImageButton(image: nil, index: 1)
    private let regularProfileButton2: ProfileImageButton = ProfileImageButton(image: nil, index: 2)
    private let regularProfileButton3: ProfileImageButton = ProfileImageButton(image: nil, index: 3)
    private let regularProfileButton4: ProfileImageButton = ProfileImageButton(image: nil, index: 4)
    private let regularProfileButton5: ProfileImageButton = ProfileImageButton(image: nil, index: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        //Configure the view
        configureView()
    }
    
    
    //MARK: - Helpers
    
    public func getHeight() -> CGFloat {
        return regularProfileButtonWidth * NUMBER_OF_COLUMNS + TOTAL_HEIGHT_PADDING
    }
    
    private func configureView() {
        
        backgroundColor = .white
        
        
        let rightColumn = createRightColumn()
        
        let leftColumn = createLeftColumn()
        
        addSubview(rightColumn)
        addSubview(leftColumn)
        
        rightColumn.anchor(top: topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 20))
        rightColumn.constrainWidth(regularProfileButtonWidth)
        
        leftColumn.anchor(top: topAnchor, left: leadingAnchor, right: rightColumn.leadingAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 10)
        
        
    }
    
    private func createRightColumn() -> UIStackView {
        
        let rightColumn = UIStackView(arrangedSubviews: [
                                        regularProfileButton1,
                                        regularProfileButton2,
                                        regularProfileButton3].map({ profileImage in
                                            profileImage.constrainHeight(regularProfileButtonWidth)
                                            profileImage.constrainWidth(regularProfileButtonWidth)
                                            return profileImage
                                        }))

        rightColumn.axis = .vertical
        rightColumn.distribution = .fillEqually
        rightColumn.spacing = 10
        
        
        return rightColumn
        
        
    }
    
    
    private func createLeftColumn() -> UIStackView {
        
        let lowerLeftColumn = UIStackView(arrangedSubviews: [
                                            regularProfileButton4,
                                            regularProfileButton5].map({ profileImage in
                                                profileImage.constrainHeight(regularProfileButtonWidth)
                                                profileImage.constrainWidth(regularProfileButtonWidth)
                                                return profileImage
                                            }))
        
        bigProfileButton.constrainWidth(regularProfileButtonWidth * 2 + 10)
        bigProfileButton.constrainHeight(regularProfileButtonWidth * 2 + 10)
        
        lowerLeftColumn.spacing = 10
        lowerLeftColumn.distribution = .fillEqually
        
        let leftColumn = UIStackView(arrangedSubviews: [bigProfileButton, lowerLeftColumn])
        leftColumn.axis = .vertical
        leftColumn.spacing = 10

        return leftColumn
        
    }


}
