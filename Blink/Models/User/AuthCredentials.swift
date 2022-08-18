//
//  AuthCredentials.swift
//  Blink
//
//  Created by Michael Abrams on 8/10/22.
//

import UIKit

public struct AuthCredentials {
    
    //Uses default values
    var email: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var password: String = ""
    var birthday: Date = Date()
    var gender: Gender = .male
    var preference: Gender = .male
    var profilePicutre: UIImage = UIImage(systemName: "plus")!
    var location: Location = Location(longitude: 0, latitude: 0, geoHash: "")
    
}
