//
//  PersonDescriptorLabel.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

protocol PersonDescriptorDelegate: AnyObject {
    func wantsToShowStatScreen()
}

class PersonDescriptor: UIView {
    
    //MARK: - Fields
    
    /** PERSON_DESCRIPTOR_CORNER_RADIUS is the corner radius for the view*/
    private let PERSON_DESCRIPTOR_CORNER_RADIUS: CGFloat = 24
    
    private let nameAndAgeLabel = UILabel()
    
    private let distanceLabel = UILabel()
    
    private let statsButton: UIButton = StatsButton(frame: .zero)
    
    public weak var delegate: PersonDescriptorDelegate?

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Add subviews
        [nameAndAgeLabel, distanceLabel, statsButton].forEach({addSubview($0)})
        
        //Configure fields
        configureFields()
        
        //Add target for stat button
        statsButton.addTarget(self, action: #selector(statsButtonTapped), for: .touchUpInside)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Configure the UI
        configureUI()
        
    }
    
    //MARK: - Actions
    
    @objc private func statsButtonTapped() {
        delegate?.wantsToShowStatScreen()
    }
    
    public func setNameAndAge(text: NSAttributedString) {
        nameAndAgeLabel.attributedText = text
    }
    
    public func setDistanceLabel(text: NSAttributedString) {
        distanceLabel.attributedText = text
    }
    
    
    //MARK: - Helper
    
    private func configureFields() {
        //Sets the corner radius for the view
        layer.cornerRadius = PERSON_DESCRIPTOR_CORNER_RADIUS
        
        //Sets the view to white
        backgroundColor = .white
    }
    
    private func configureUI() {
        
        //Sets the constraints
        nameAndAgeLabel.anchor(top: topAnchor, leading: leadingAnchor, padding: UIEdgeInsets(top: 5, left: 15, bottom: .zero, right: .zero))

        //Sets the constraints for the distance label
        distanceLabel.anchor(top: nameAndAgeLabel.bottomAnchor, leading: nameAndAgeLabel.leadingAnchor, padding: UIEdgeInsets(top: -5, left: .zero, bottom: .zero, right: .zero))

        
        //Constrains the statsButton based on which label is longer
        if(distanceLabel.intrinsicContentSize.width > nameAndAgeLabel.intrinsicContentSize.width) {
            statsButton.anchor(top: topAnchor, leading: distanceLabel.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        else {
            statsButton.anchor(top: topAnchor, leading: nameAndAgeLabel.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
    }

}
