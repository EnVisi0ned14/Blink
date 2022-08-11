//
//  CardView.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit

class CardView: UIView {

    //MARK: - Fields
    
    /** CARD_CORNER_RADIUS is the corner radius for the card view*/
    private let CARD_CORNER_RADIUS: CGFloat = 22
    
    //Is the image the card view displays
    private let cardImageView: UIImageView = UIImageView(image: UIImage(named: "daisy"))
    
    //Is the view used to displaye the person's name, age, distance, and stats button
    private let personDescriptor = PersonDescriptor()
    

    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Configures the card's fields
        configureCardFields()
        
        //Configure the UI for the card view
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    
    //Configures the card view's fields
    private func configureCardFields() {
        
        //Sets the corner radius for the card
        layer.cornerRadius = CARD_CORNER_RADIUS
        //Adds clipping
        clipsToBounds = true
        
    }
    
    //Configures the UI for the card view
    private func configureUI() {
        
        //Add the card image to the subview
        addSubview(cardImageView)
        //Content mode set to fill
        cardImageView.contentMode = .scaleAspectFill
        //Fill the card with the image
        cardImageView.fillSuperview()
        
        
        //Add the person descriptor to the subview
        addSubview(personDescriptor)
        
        //Set the constraints for the person descriptor
        personDescriptor.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: .zero, left: 10, bottom: 5, right: 10), size: CGSize(width: .zero, height: 75))
        
    }
    
}
