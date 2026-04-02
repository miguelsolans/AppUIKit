//
//  STCoreUIConfiguration.swift
//  STCoreUI
//
//  Created by Miguel Solans on 03/03/2024.
//

import Foundation

public struct STCoreUIConfiguration {
    public let dateFormat: String
    public let dateAndTimeFormat: String
    
    public init(dateFormat: String, dateAndTimeFormat: String) {
        self.dateFormat = dateFormat
        self.dateAndTimeFormat = dateAndTimeFormat
    }
}
