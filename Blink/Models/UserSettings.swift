//
//  UserSettings.swift
//  Blink
//
//  Created by Michael Abrams on 8/10/22.
//

import Foundation

public struct UserSettings {
    
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
    
    init?(userNode: [String: Any]) {
        
        guard let minSeekingAge = userNode[MIN_SEEKING_AGE] as? Int,
              let maxSeekingAge = userNode[MAX_SEEKING_AGE] as? Int,
              let distanceRange = userNode[DISTANCE_RANGE] as? Int,
              let genderString = userNode[GENDER] as? String,
              let gender = Gender(rawValue: genderString),
              let preferenceString = userNode[PREFERENCE] as? String,
              let preference = Gender(rawValue: preferenceString),
              let geoHash = userNode[GEO_HASH] as? String,
              let latitude = userNode[LATITUDE] as? Double,
              let longitude = userNode[LONGITUDE] as? Double else { return nil }
        
        self.init(minSeekingAge: minSeekingAge, maxSeekingAge: maxSeekingAge, distanceRange: distanceRange, gender: gender, preference: preference, geoHash: geoHash, latitude: latitude, longitude: longitude)
        
    }
    
}
