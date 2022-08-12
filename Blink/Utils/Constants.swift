//
//  Constants.swift
//  Blink
//
//  Created by Michael Abrams on 8/8/22.
//

import Foundation
import FirebaseFirestore
import Geofirestore

//MARK: - Firestore collection constants
let COLLECTION_MALE_USERS = Firestore.firestore().collection("male_users")
let COLLECTION_FEMALE_USERS = Firestore.firestore().collection("female_users")
let COLLECTION_SWIPES = Firestore.firestore().collection("swipes")


let COLLECTION_LOCATION_MALE = GeoFirestore(collectionRef: COLLECTION_MALE_USERS)
let COLLECTION_LOCATION_FEMALE = GeoFirestore(collectionRef: COLLECTION_FEMALE_USERS)


//MARK: - Observer Constants
let USER_LOGGED_IN = "User_Logged_In"


//MARK: - User Constants

let MAX_AGE: Int = 60
let MIN_AGE: Int = 18

let MAX_DISTANCE_RANGE: Int = 50

//USER NODE KEYS

//User profile
let AGE = "age"
let OCUPATION = "ocupation"
let SCHOOL = "school"
let BIO = "bio"
let BIRTHDAY = "birthday"
let FIRST_NAME = "first_name"
let LAST_NAME = "last_name"
let PROFILE_PICTURES = "profile_pictures"

//User settings

let MAX_SEEKING_AGE_KEY = "max_seeking_age"
let MIN_SEEKING_AGE = "min_seeking_age"
let DISTANCE_RANGE = "distance_range"
let PREFERENCE = "preference"
let GENDER = "gender"
let LATITUDE = "latitude"
let LONGITUDE = "longitude"
let GEO_HASH = "geoHash"

//User
let EMAIL = "email"
let UID = "uid"
let USER_PROFILE = "user_profile"
let USER_SETTINGS = "user_settings"


