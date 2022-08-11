//
//  PersonDescriptorLabel.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

class PersonDescriptor: UIView {
    
    //MARK: - Fields
    
    /** PERSON_DESCRIPTOR_CORNER_RADIUS is the corner radius for the view*/
    private let PERSON_DESCRIPTOR_CORNER_RADIUS: CGFloat = 24
    
    private let nameAndAgeLabel: UILabel = {
        let lbl = UILabel()
        
        //Create and add the name string
        let nameAndAgeString = NSMutableAttributedString(string: "Katie", attributes: [.font: UIFont.systemFont(ofSize: 30, weight: .black), .foregroundColor: UIColor.black])
        
        //Append the age to the string
        nameAndAgeString.append(NSAttributedString(string: "  22", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .semibold), .foregroundColor: UIColor.black]))
        
        //Add the string to the label
        lbl.attributedText = nameAndAgeString
        
        return lbl
    }()
    
    private let distanceLabel: UILabel = {
        
        let lbl = UILabel()
        
        //Create the distance string
        let distanceString = NSMutableAttributedString(string: "25 miles away", attributes: [.font: UIFont.systemFont(ofSize: 22, weight: .medium), .foregroundColor: UIColor.distanceLabelColor])
        
        //Add the string to the label
        lbl.attributedText = distanceString
        
        return lbl
    }()
    
    private let statsButton: UIButton = StatsButton(frame: .zero)

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Configure fields
        configureFields()
        
        //Configure the UI
        configureUI()
        
        //Add target for stat button
        statsButton.addTarget(self, action: #selector(statsButtonTapped), for: .touchUpInside)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc private func statsButtonTapped() {
        print("DEBUG: Stats button tapped")
    }
    
    
    //MARK: - Helper
    
    private func configureFields() {
        //Sets the corner radius for the view
        layer.cornerRadius = PERSON_DESCRIPTOR_CORNER_RADIUS
        
        //Sets the view to white
        backgroundColor = .white
    }
    
    private func configureUI() {
        
        //Adds the nameAndAge label to the view
        addSubview(nameAndAgeLabel)
        
        //Sets the constraints
        nameAndAgeLabel.anchor(top: topAnchor, leading: leadingAnchor, padding: UIEdgeInsets(top: 5, left: 15, bottom: .zero, right: .zero))
        
        //Adds the distance label to the view
        addSubview(distanceLabel)

        //Sets the constraints for the distance label
        distanceLabel.anchor(top: nameAndAgeLabel.bottomAnchor, leading: nameAndAgeLabel.leadingAnchor, padding: UIEdgeInsets(top: -5, left: .zero, bottom: .zero, right: .zero))
        
        //Adds the stat's button as a subview
        addSubview(statsButton)
        
        //Constrains the statsButton based on which label is longer
        if(distanceLabel.intrinsicContentSize.width > nameAndAgeLabel.intrinsicContentSize.width) {
            statsButton.anchor(top: topAnchor, leading: distanceLabel.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        else {
            statsButton.anchor(top: topAnchor, leading: nameAndAgeLabel.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
    
        
    }

}
