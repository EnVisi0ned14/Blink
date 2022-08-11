//
//  LocationManager.swift
//  Blink
//
//  Created by Michael Abrams on 8/8/22.
//

import UIKit
import CoreLocation
import GeoFire
import SwiftLocation

public struct Location {
    
    let longitude: Double
    let latitude: Double
    let geoHash: String
    
}

public class LocationManager {
    
    public static let shared = LocationManager()
    
    public func getCurrentLocation(completion: @escaping (Result<Location, Error>) -> Void) {
        
        SwiftLocation.gpsLocation().then { result in
            switch result {
            case .success(let data):
            
                //Pull latitude and longitude
                let latitude = data.coordinate.latitude
                let longitude = data.coordinate.longitude
                
                //Get location
                let newLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                //Create hash
                let hash = GFUtils.geoHash(forLocation: newLocation)
                
                //Return result
                completion(.success(Location(longitude: longitude, latitude: latitude, geoHash: hash)))
                
            case .failure(let error):
                //Return error
                completion(.failure(error))
            }
            
        }
    }
}


