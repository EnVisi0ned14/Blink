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
        
        guard let userSettings = userNode[USER_SETTINGS] as? [String: Any],
              let minSeekingAge = userSettings[MIN_SEEKING_AGE] as? Int,
              let maxSeekingAge = userSettings[MAX_SEEKING_AGE_KEY] as? Int,
              let distanceRange = userSettings[DISTANCE_RANGE] as? Int,
              let genderString = userSettings[GENDER] as? String,
              let gender = Gender(rawValue: genderString),
              let preferenceString = userSettings[PREFERENCE] as? String,
              let preference = Gender(rawValue: preferenceString),
              let geoHash = userSettings[GEO_HASH] as? String,
              let latitude = userSettings[LATITUDE] as? Double,
              let longitude = userSettings[LONGITUDE] as? Double else { return nil }
        
        self.init(minSeekingAge: minSeekingAge, maxSeekingAge: maxSeekingAge, distanceRange: distanceRange, gender: gender, preference: preference, geoHash: geoHash, latitude: latitude, longitude: longitude)
        
    }
    
}
