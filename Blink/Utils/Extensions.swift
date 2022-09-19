//
//  Extensions.swift
//  Blink
//
//  Created by Stephen Dowless on 4/30/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import UIKit
import GTProgressBar

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIColor {
    static let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    
    //Color used in the top stack view for the blink label
    static let blinkLabelColor = UIColor(red: 246 / 255.0, green: 131 / 255.0, blue: 75 / 255.0, alpha: 1)
    
    //Color used in the person descriptor for the distance
    static let distanceLabelColor = UIColor(red: 104 / 255.0, green: 104 / 255.0, blue: 104 / 255.0, alpha: 1)
    
    //Color used for the profile background button
    static let profileButtonBackgroundColor = UIColor(red: 252 / 255.0, green: 222 / 255.0, blue: 196 / 255.0, alpha: 1)
    
    //Color used for the profile imageView plus tint
    static let profilePlusTintColor = UIColor(red: 251 / 255.0, green: 156 / 255.0, blue: 62 / 255.0, alpha: 1)
    
    //Color used for the setting's status text to display the slider info
    static let settingStatusColor = UIColor(red: 75 / 255.0, green: 72 / 255.0, blue: 72 / 255.0, alpha: 1)
    
    //Color used for the description on the Blink Plus button
    static let blinkPlusDescriptionColor = UIColor(red: 247 / 255.0, green: 247 / 255.0, blue: 73 / 255.0, alpha: 1)
    
    //Color used for placeholder text
    static let placeHolderColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1)
}

extension UIViewController {
    func configureGradientLayer() {
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.337254902, blue: 0.007843137255, alpha: 1)
        let bottomColor = #colorLiteral(red: 1, green: 0.6862745098, blue: 0.2588235294, alpha: 1)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.frame
    }
}

extension UIButton {
    
    func configureGradientLayer() {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [#colorLiteral(red: 0.9725490196, green: 0.4156862745, blue: 0.007843137255, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.4549019608, blue: 0.09019607843, alpha: 1).cgColor, #colorLiteral(red: 0.937254902, green: 0.4470588235, blue: 0.08235294118, alpha: 1).cgColor, #colorLiteral(red: 0.9764705882, green: 0.5058823529, blue: 0.1647058824, alpha: 1).cgColor, #colorLiteral(red: 0.968627451, green: 0.5960784314, blue: 0.3843137255, alpha: 1).cgColor]
        gradientLayer.locations = [0, 0.2, 0.4, 0.6, 1]
        layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = bounds
        
       
        
    }
    
    func configureBorderGradient() {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  CGRect(origin: .zero, size: frame.size)
        gradientLayer.colors = [#colorLiteral(red: 0.9725490196, green: 0.4156862745, blue: 0.007843137255, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.4549019608, blue: 0.09019607843, alpha: 1).cgColor, #colorLiteral(red: 0.937254902, green: 0.4470588235, blue: 0.08235294118, alpha: 1).cgColor, #colorLiteral(red: 0.9764705882, green: 0.5058823529, blue: 0.1647058824, alpha: 1).cgColor, #colorLiteral(red: 0.968627451, green: 0.5960784314, blue: 0.3843137255, alpha: 1).cgColor]
        
        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradientLayer.mask = shape

        layer.addSublayer(gradientLayer)
    }
    
    func removeGradientLayer() {
        
        if let layers = layer.sublayers {
            for layer in layers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                    break
                }
            }
        }
    }
    
    func hasGradientLayer() -> Bool {
        
        if let layers = layer.sublayers {
            for layer in layers {
                if layer is CAGradientLayer {
                    return true
                }
            }
        }
        
        return false
        
    }
    
}

enum LinePosition {
    case top
    case bottom
}

extension Date {
    
    
    static func getAgeFromDate(for date: Date) -> Int? {
        
        //Grab calendar
        let calendar = NSCalendar.current
        
        //Grab age components
        let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
        
        //Return the year
        return ageComponents.year
        
    }
    
    
    
}

extension UIView {
    
    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func addLine(position: LinePosition, color: UIColor, width: Double) {
        
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
        
        let metrics = ["width": NSNumber(value: width)]
        let views = ["lineView": lineView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        switch position {
        case .top:
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: views))
             break
        case .bottom:
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: views))
            break
        }
        
    }
    
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                   left: NSLayoutXAxisAnchor? = nil,
                   bottom: NSLayoutYAxisAnchor? = nil,
                   right: NSLayoutXAxisAnchor? = nil,
                   paddingTop: CGFloat = 0,
                   paddingLeft: CGFloat = 0,
                   paddingBottom: CGFloat = 0,
                   paddingRight: CGFloat = 0,
                   width: CGFloat? = nil,
                   height: CGFloat? = nil) {
           
           translatesAutoresizingMaskIntoConstraints = false
           
           if let top = top {
               topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
           }
           
           if let left = left {
               leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
           }
           
           if let bottom = bottom {
               bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
           }
           
           if let right = right {
               trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
           }
           
           if let width = width {
               widthAnchor.constraint(equalToConstant: width).isActive = true
           }
           
           if let height = height {
               heightAnchor.constraint(equalToConstant: height).isActive = true
           }
       }
       
       func centerX(inView view: UIView) {
           translatesAutoresizingMaskIntoConstraints = false
           centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       }
       
       func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                    paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
           
           translatesAutoresizingMaskIntoConstraints = false
           centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
           
           if let left = leftAnchor {
               anchor(left: left, paddingLeft: paddingLeft)
           }
       }
       
       func setDimensions(height: CGFloat, width: CGFloat) {
           translatesAutoresizingMaskIntoConstraints = false
           heightAnchor.constraint(equalToConstant: height).isActive = true
           widthAnchor.constraint(equalToConstant: width).isActive = true
       }
    
    @discardableResult
    open func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    @discardableResult
    open func fillSuperview(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let anchoredConstraints = AnchoredConstraints()
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leadingAnchor,
            let superviewTrailingAnchor = superview?.trailingAnchor else {
                return anchoredConstraints
        }
        
        return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }
    
    @discardableResult
    open func fillSuperviewSafeAreaLayoutGuide(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        let anchoredConstraints = AnchoredConstraints()
        if #available(iOS 11.0, *) {
            guard let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor,
                let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor,
                let superviewLeadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor,
                let superviewTrailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor else {
                    return anchoredConstraints
            }
            return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
            
        } else {
            return anchoredConstraints
        }
    }
    
    open func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    open func centerXToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
    }
    
    open func centerYToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
    }
    
    @discardableResult
    open func constrainHeight(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.height?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    open func constrainWidth(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.width?.isActive = true
        return anchoredConstraints
    }
    
    open func setupShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
    convenience public init(backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
}

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension GTProgressBar {
    
    public static func createBlinkProgressBar(progress: CGFloat) -> GTProgressBar {
        
        let progressBar = GTProgressBar()
        
        //Remove the progress display label
        progressBar.displayLabel = false
        
        //Set the progress fill color
        progressBar.barFillColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        progressBar.barFillInset = 0
        
        //Set border colore to clear
        progressBar.barBackgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
        
        progressBar.barBorderColor = .clear
        
        
        //Set the progress status
        progressBar.progress = progress
        
        //Set rounded bar
        progressBar.cornerType = GTProgressBarCornerType.rounded
        
        return progressBar
        
    }
    
    
}

extension UITextField {
    
    
    func setBottomLine(borderColor: UIColor) {

        borderStyle = .none

        backgroundColor = .clear

        let borderLine = CALayer()

        borderLine.frame = CGRect(x: 0, y: frame.height - 2, width: frame.width, height: 2)
        borderLine.backgroundColor = borderColor.cgColor

        layer.addSublayer(borderLine)



    }
    
    
}
