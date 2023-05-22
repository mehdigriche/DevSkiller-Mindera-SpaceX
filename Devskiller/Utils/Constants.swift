//
//  Constants.swift
//  Devskiller
//
//  Created by GRICHE, MEHDI on 21/5/2023.
//  Copyright © 2023 Mindera. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    let BASE_URL = URL(string: "https://api.spacexdata.com/v4/")!
    let rocketUrl = "rockets/"
    let companyUrl = "company"
    let launchUrl = "launches"
    
    func formatAsCurrency(number: Int, currencyCode: String) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        
        return formatter.string(from: NSNumber(value: number))
    }
    
    func separateDateAndTime(from dateTimeString: String) -> (date: String, time: String)? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        // Parse the input string intp a Date object
        guard let date = dateFormatter.date(from: dateTimeString) else { return nil }
        
        // Set the output format for the date component
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        
        // Set the output format for the time component
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm:ss"
        
        // Get the separate date and time components as strings
        let dateComponent = dateFormat.string(from: date)
        let timeComponent = timeFormat.string(from: date)
        
        // Return the separate date and time components as a tuple
        return (dateComponent, timeComponent)
    }
    
    func calculateDays(from dateTime: String) -> (Int?, String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let dateTime = dateFormatter.date(from: dateTime) {
            let calendar = Calendar.current
            
            // Get the current date and time
            let currentDate = Date()
            
            // Specify the components wanted to include in the calculation, our case : Day
            let components = calendar.dateComponents([.day], from: calendar.startOfDay(for: currentDate), to: calendar.startOfDay(for: dateTime))
            
            // Retrieve the number of days from the components
            guard let days = components.day else {
                return (nil, "")
            }
            
            let absoluteDays = abs(days)
            let dayString = absoluteDays == 1 ? "day" : "days"
            
            let prefix = days >= 0 ? "since" : "from"
            
            return (absoluteDays, "\(dayString) \(prefix) now")
        }
        return (nil, "")
    }
    
    func openLinkInBrowser(url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(
                url,
                options: [:],
                completionHandler: nil
            )
        }
    }
}
