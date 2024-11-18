//
//  STCoreUIConfigurationManager.swift
//  STCoreUI
//
//  Created by Miguel Solans on 03/03/2024.
//

import Foundation

/// A manager to store project level Core settings
public class STCoreUIConfigurationManager {
    /// The shared instance of the CoreConfigurationManager.
    public static let shared = STCoreUIConfigurationManager()
    
    public var configuration: STCoreUIConfiguration
    
    private init() {
        let configuration = STCoreUIConfiguration(dateFormat: "yyyy-MM-dd", dateAndTimeFormat: "yyyy-MM-dd HH:mm");
        
        self.configuration = configuration;
    }
}

public extension STCoreUIConfigurationManager {
    func setup(configuration: STCoreUIConfiguration) {
        self.configuration = configuration;
    }
}

extension STCoreUIConfigurationManager {
    func getDateFormat() -> String {
        return self.configuration.dateFormat;
    }
    
    func getDateAndTimeFormat() -> String {
        return self.configuration.dateAndTimeFormat;
    }
    
    func getUserReadableDate() -> String {
        return self.configuration.dateFormat
    }
}
