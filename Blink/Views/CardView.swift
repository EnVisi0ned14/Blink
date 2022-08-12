//
//  CardView.swift
//  Blink
//
//  Created by Michael Abrams on 7/24/22.
//

import UIKit
import SDWebImage

protocol CardViewDelegate: AnyObject {
    func cardView(_ view: CardView, wantsToShowStatsFor user: User)
    func cardView(_ view: CardView, didLikeUser: Bool)
}

enum SwipeDirection: Int {
    case left = -1
    case right = 1
}

class CardView: UIView {

    //MARK: - Fields
    
    /** CARD_CORNER_RADIUS is the corner radius for the card view*/
    private let CARD_CORNER_RADIUS: CGFloat = 22
    
    //Is the image the card view displays
    private let cardImageView = UIImageView()
    
    public weak var delegate: CardViewDelegate?
    
    //Is the view used to displaye the person's name, age, distance, and stats button
    private let personDescriptor = PersonDescriptor()
    
    public var cardViewModel: CardViewModel!
    
    //MARK: - Lifecycle
    
    init(cardViewModel: CardViewModel) {
        self.cardViewModel = cardViewModel
        super.init(frame: .zero)
        
        //Configure card
        configureCard()
        
        //Handle delegates
        personDescriptor.delegate = self
        
        //Configures the card's fields
        configureCardFields()
        
        //Configure gesture recognizers
        configureGestureRecognizers()
        
        //Configure the UI for the card view
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
        case .changed:
            panCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
        default:
            break
        }
        
    }
    
    @objc func handleChangePhoto(sender: UITapGestureRecognizer) {
        let location = sender.location(in: nil).x
        let shouldShowNextPhoto = location > self.frame.width / 2
        
        if(shouldShowNextPhoto) {
            cardViewModel.showNextPhoto()
        }
        else {
            cardViewModel.showPreviousPhoto()
        }
        
        cardImageView.sd_setImage(with: cardViewModel.imageUrl)
        
    }
    
    //MARK: - Helpers
    
    func panCard(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    func resetCardPosition(sender: UIPanGestureRecognizer) {
        
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            
            if shouldDismissCard {
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
            }
            else {
                self.transform = .identity
            }
            
        } completion: { _ in
            
            if shouldDismissCard {
                let didLike = direction == .right
                self.delegate?.cardView(self, didLikeUser: didLike)
            }
            
        }

    }
    
    func configureGestureRecognizers() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
    }
    
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
    
    private func configureCard() {
        
        //Set name and age text
        personDescriptor.setNameAndAge(text: cardViewModel.nameAndAgeString)
        
        //Set distance text
        personDescriptor.setDistanceLabel(text: cardViewModel.distanceString)
        
        //Set image
        cardImageView.sd_setImage(with: cardViewModel.imageUrl)
        
    }
    
}


//MARK: - PersonDescriptorDelegate

extension CardView: PersonDescriptorDelegate {
    
    func wantsToShowStatScreen() {
        delegate?.cardView(self, wantsToShowStatsFor: cardViewModel.user)
    }
    
}
