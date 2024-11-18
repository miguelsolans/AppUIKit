//
//  Date+Formatting.swift
//  STCoreUI
//
//  Created by Miguel Solans on 03/03/2024.
//

import Foundation

extension Date {
    
    /// Formats the date to a string in a specific format.
    ///
    /// Useful when posting data to the backend. The returned date string will appear as, for example, "1998-08-31".
    ///
    /// - Returns: The formatted date as a string.
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = STCoreUIConfigurationManager.shared.getDateFormat();
        
        return dateFormatter.string(from: self);
    }
    
    /// Formats the date to a string with time in a specific format.
    ///
    /// The returned date string will appear as, for example, "1998-08-31 19:37".
    ///
    /// - Returns: The formatted date with time as a string.
    func getFormatterDateAndTime() -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = STCoreUIConfigurationManager.shared.getDateAndTimeFormat()
        
        return dateFormatter.string(from: self);
    }
    
    /// Formats the date to a more user-friendly format.
    ///
    /// Useful for UI purposes only. The returned date string will appear in a human-readable format.
    ///
    /// - Returns: The formatted date as a string.
    func getUserReadableDate() -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = STCoreUIConfigurationManager.shared.getUserReadableDate();
        
        return dateFormatter.string(from: self);
    }
    
    /// Converts the date to date components.
    ///
    /// - Returns: The date as date components.
    func dateToComponents() -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return components
    }
    
}
