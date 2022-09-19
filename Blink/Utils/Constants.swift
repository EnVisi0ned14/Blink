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
let COLLECTION_MATCHES = Firestore.firestore().collection(MATCHES)
let MATCHES = "matches"
let COLLECTION_CONVERSATIONS = Firestore.firestore().collection(CONVERSATIONS)

let COLLECTION_LOCATION_MALE = GeoFirestore(collectionRef: COLLECTION_MALE_USERS)
let COLLECTION_LOCATION_FEMALE = GeoFirestore(collectionRef: COLLECTION_FEMALE_USERS)


//MARK: - Observer Constants
let USER_LOGGED_IN = "User_Logged_In"
let USER_LOGGED_OUT = "User_Logged_Out"


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
let FULL_NAME = "full_name"
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

//User stats
let USER_STATS = "user_stats"
let GHOSTED = "ghosted"
let NUMBER_OF_SWIPES = "number_of_swipes"
let NUMBER_OF_TIMES_SWIPED_ON = "number_of_times_swiped_on"
let SWIPED_RIGHT_ON = "swiped_right_on"
let SWIPED_LEFT_ON = "swiped_left_on"
let SWIPED_RIGHT = "swiped_right"
let SWIPED_LEFT = "swiped_left"

//User
let EMAIL = "email"
let UID = "uid"
let USER_PROFILE = "user_profile"
let USER_SETTINGS = "user_settings"


//Conversation
let LATEST_MESSAGE = "latest_message"
let CONVERSATION_ID = "conversation_id"
let SENDER_UID = "sender_uid"
let MESSAGES = "messages"
let SENDER_NAME = "sender_name"
let TEXT_MESSAGE = "text_message"
let DATE = "date"
let TYPE = "type"
let CONVERSATIONS = "conversations"
let MESSAGE_ID = "message_id"

//Match
let BEGAN_CONVERSATION = "began_conversation"
