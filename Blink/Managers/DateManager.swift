//
//  DateManager.swift
//  Blink
//
//  Created by Michael Abrams on 8/9/22.
//

import Foundation

public class DateManager {
    
    private static let dateFormater: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YY/MM/dd"
        return dateFormater
    }()
    
    public static func getDateString(from date: Date) -> String {
        return dateFormater.string(from: date)
    }
    
    public static func getDateFromString(from dateString: String) -> Date? {
        return dateFormater.date(from: dateString)
    }
    
    
}
