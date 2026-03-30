//
//  BaseInputViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 29/03/2026.
//

import Foundation

/// Base class for all input UI elements (TextField, DatePicker, OptionPicker, etc.)
public class BaseInputViewModel {
    
    /// The title of the input field
    let title: String
    
    /// Placeholder text (e.g., hint inside a textfield)
    let placeholder: String?
    
    /// Optional subtitle / description below the field
    let subtitle: String?
    
    /// Marks whether the field is mandatory
    let isMandatory: Bool
    
    /// Marks whether the field user interaction is enable
    let isEnabled: Bool
    
    /// Current error message (optional, can be set by validation logic later)
    var errorMessage: String?
    
    init(title: String,
         placeholder: String? = nil,
         subtitle: String? = nil,
         isMandatory: Bool = false,
         isEnabled: Bool = true,
         errorMessage: String? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.subtitle = subtitle
        self.isMandatory = isMandatory
        self.isEnabled = isEnabled
        self.errorMessage = errorMessage
    }
}
