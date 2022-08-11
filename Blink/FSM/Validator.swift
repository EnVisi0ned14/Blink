//
//  EmailFSM.swift
//  Blink
//
//  Created by Michael Abrams on 8/4/22.
//

import Foundation




public class Validator {
    
    private static let MIN_AGE: Int = 18
    
    private static let MAX_AGE: Int = 60
    
    public static func emailIsValid(for email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email)
        
    }
    
    public static func passwordIsValid(for password: String) -> Bool {
        return password.count >= 7
    }
    
    public static func firstNameIsValid(for firstName: String?) -> Bool {
        
        guard let firstName = firstName else { return false }
        
        return firstName.count >= 1
    }
    
    public static func lastNameIsValid(for lastName: String?) -> Bool {
        
        guard let lastName = lastName else { return false }
        
        return lastName.count >= 1
    }
    
    public static func birthdayIsValid(for birthDay: Date) -> Bool {
        
        //Grab the age
        let age = Date.getAgeFromDate(for: birthDay)
        
        guard let safeAge = age else { return false }
        
        //Return valid status
        return safeAge >= MIN_AGE && safeAge <= MAX_AGE

        
    }
    
}


