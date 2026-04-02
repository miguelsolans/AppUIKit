//
//  BaseInputViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 29/03/2026.
//

import Foundation

/// `BaseInputViewModel` is a base model used to configure customizable user input components.
/// It defines common properties such as title, placeholder, subtitle, and validation state.
///
///  Example Usage:
///  ```swift
///  let viewModel = BaseInputViewModel(
///      title: "Email",
///      placeholder: "Enter your email",
///      isMandatory: true
///  )
///  ```
open class BaseInputViewModel {
    
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

// MARK: - Bottom Label Type Enum
public enum BottomLabelType {
    case successType
    case warningType
    case errorType
    case informativeType
}
