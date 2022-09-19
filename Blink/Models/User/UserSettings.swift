//
//  UserSettings.swift
//  Blink
//
//  Created by Michael Abrams on 8/10/22.
//

import Foundation

public struct UserSettings: Codable {
    
    var minSeekingAge: Int
    var maxSeekingAge: Int
    var distanceRange: Int
    var gender: Gender
    var preference: Gender
    var geoHash: String
    var latitude: Double
    var longitude: Double

    init(minSeekingAge: Int, maxSeekingAge: Int, distanceRange: Int, gender: Gender,
         preference: Gender, geoHash: String, latitude: Double, longitude: Double) {
        
        self.maxSeekingAge = maxSeekingAge
        self.minSeekingAge = minSeekingAge
        self.distanceRange = distanceRange
        self.gender = gender
        self.preference = preference
        self.geoHash = geoHash
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    enum CodingKeys: String, CodingKey {
        
        case minSeekingAge = "min_seeking_age"
        case maxSeekingAge = "max_seeking_age"
        case distanceRange = "distance_range"
        case gender = "gender"
        case preference = "preference"
        case geoHash = "geoHash"
        case latitude = "latitude"
        case longitude = "longitude"
        
    }
    
}
