//
//  DateUtils.swift
//  Lloyds
//
//  Created by Mahesh Varadaraj on 09/06/22.
//

import Foundation

public class DateUtils {

    static func formatDate(date: String) -> String {
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = K.DateTimeFormat.apiResponseDate
        let convertedDateFormatter = DateFormatter()
        convertedDateFormatter.dateFormat =  K.DateTimeFormat.convertedDate
        let dateValue = currentDateFormatter.date(from: date)
        return convertedDateFormatter.string(from: dateValue ?? Date())
    }
    
    static func sortByDate(date: String) -> Date {
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = K.DateTimeFormat.apiResponseDate
        let convertedDateFormatter = DateFormatter()
        convertedDateFormatter.dateFormat =  K.DateTimeFormat.convertedDate
        let dateValue = currentDateFormatter.date(from: date)
        return dateValue ?? Date()
    }

}
