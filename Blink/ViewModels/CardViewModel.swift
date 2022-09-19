//
//  CardViewModel.swift
//  Blink
//
//  Created by Michael Abrams on 8/11/22.
//

import UIKit

public class CardViewModel {
    
    let user: User
    let imageURLs: [String]
    var nameAndAgeString: NSAttributedString
    var distanceString: NSAttributedString
    
    var pictureCount: Int {
        return imageURLs.filter({!$0.isEmpty}).count
    }
    
    var imageUrl: URL?
    
    
    private var imageIndex = 0
    var index: Int { return imageIndex }
    
    init(user: User) {
        //Set the user
        self.user = user
        
        //Create and add the name string
        let nameAndAgeString = NSMutableAttributedString(string: "\(user.userProfile.firstName)", attributes: [.font: UIFont.systemFont(ofSize: 30, weight: .black), .foregroundColor: UIColor.black])
        
        //Get the age
        let age = user.userProfile.age
        
        //Append the age to the string
        nameAndAgeString.append(NSAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .semibold), .foregroundColor: UIColor.black]))
        
        self.nameAndAgeString = nameAndAgeString
        
        //Set the distance string
        self.distanceString = NSMutableAttributedString(string: "25 miles away", attributes: [.font: UIFont.systemFont(ofSize: 22, weight: .medium), .foregroundColor: UIColor.distanceLabelColor])
        
        self.imageURLs = user.userProfile.profilePictures
        self.imageUrl = URL(string: self.imageURLs[0])
        
    }
    
    func showNextPhoto() {
        
        //If the next image url is empty return
        guard !imageURLs[imageIndex + 1].isEmpty else { return }
        
        //Increase the image index
        imageIndex += 1
        
        imageUrl = URL(string: imageURLs[imageIndex])
        
    }
    
    func showPreviousPhoto() {
        
        //If the image index can not go back
        guard imageIndex > 0 else { return }
        
        
        imageIndex -= 1
        imageUrl = URL(string: imageURLs[imageIndex])
        
    }
    
}
