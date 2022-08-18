//
//  MatchScreenView.swift
//  Blink
//
//  Created by Michael Abrams on 8/13/22.
//

import UIKit
import SDWebImage

class MatchScreenView: UIView {

    //MARK: - Fields
    
    private let viewModel: MatchViewModel
    
    private let currentUserProfileImage = MatchImageView(frame: .zero)
    private let otherUserProfileImage = MatchImageView(frame: .zero)
    
    private let matchLabel = MatchLabel()
    
    private let sendMessageButton = BlinkButton(title: "Send Message")
    private let keepSwipingButton = BlinkBorderButton(title: "Keep Swiping")
    
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    private lazy var views = [
        currentUserProfileImage,
        otherUserProfileImage,
        matchLabel,
        sendMessageButton,
        keepSwipingButton
    ]
    
    //MARK: - Lifecycle
    
    init(viewModel: MatchViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        //Add targets
        keepSwipingButton.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        sendMessageButton.addTarget(self, action: #selector(sendMessageTapped), for: .touchUpInside)
        
        //Add subviews
        configureBlurView()
        
        //Load view
        loadUserData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureUI()
        configureAnimations()
    }

    
    //MARK: - Actions
    
    @objc private func sendMessageTapped() {
        print("DEBUG: Send message tapped...")
    }
    
    @objc private func handleDismissal() {
        
        print("DEBUG: Dismissing match screen view...")
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }

    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        //Add subviews as hidden
        addAndHideSubviews()
        
        //Constrain profile image views
        currentUserProfileImage.anchor(right: centerXAnchor, paddingRight: 16)
        currentUserProfileImage.centerY(inView: self)
        otherUserProfileImage.anchor(left: centerXAnchor, paddingLeft: 16)
        otherUserProfileImage.centerY(inView: self)
        
        //Constrain send message button
        sendMessageButton.anchor(top: currentUserProfileImage.bottomAnchor, left: leadingAnchor, right: trailingAnchor, paddingTop: 32, paddingLeft: 30, paddingRight: 30)
        sendMessageButton.configureGradientLayer()
        
        //Constrain keep swiping button
        keepSwipingButton.anchor(top: sendMessageButton.bottomAnchor, left: leadingAnchor, right: trailingAnchor, paddingTop: 32, paddingLeft: 30, paddingRight: 30)
        
        //Constrain match label
        matchLabel.anchor(left: leadingAnchor, bottom: currentUserProfileImage.topAnchor, right: trailingAnchor, paddingLeft: 20, paddingBottom: 30, paddingRight: 20)
        
        
        
    }
    
    private func loadUserData() {
        currentUserProfileImage.sd_setImage(with: viewModel.currentUserImageUrl)
        otherUserProfileImage.sd_setImage(with: viewModel.matchedUserImageUrl)
    }
    
    private func configureAnimations() {
        views.forEach({$0.alpha = 1})
        
        let angle = 30 * CGFloat.pi / 180

        currentUserProfileImage.transform = CGAffineTransform(rotationAngle: -angle).concatenating(CGAffineTransform(translationX: 200, y: 0))
        otherUserProfileImage.transform = CGAffineTransform(rotationAngle: angle).concatenating(CGAffineTransform(translationX: -200, y: 0))
        
        sendMessageButton.transform = CGAffineTransform(translationX: -500, y: 0)
        keepSwipingButton.transform = CGAffineTransform(translationX: 500, y: 0)
        
        //Animations for image views
        UIView.animateKeyframes(withDuration: 1.3, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45) {
                self.currentUserProfileImage.transform = CGAffineTransform(rotationAngle: -angle)
                self.otherUserProfileImage.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                self.currentUserProfileImage.transform = .identity
                self.otherUserProfileImage.transform = .identity
            }
        }, completion: nil)
        
        //Animations for buttons
        UIView.animate(withDuration: 0.75, delay: 0.6 * 1.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.sendMessageButton.transform = .identity
            self.keepSwipingButton.transform = .identity
        }, completion: nil)
        
    }
    
    private func addAndHideSubviews() {
        views.forEach { view in
            addSubview(view)
            view.alpha = 0
        }
    }
    
    private func configureBlurView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        visualEffectView.addGestureRecognizer(tap)
        
        //Add visual effect view
        addSubview(visualEffectView)
        
        //Fill superview
        visualEffectView.fillSuperview()
        
        //Set to hidden
        visualEffectView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.visualEffectView.alpha = 1
        }, completion: nil)

    }
    
    
    
    

}
