//
//  TextFieldInputViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 30/03/2026.
//

import UIKit

public enum TextFieldType {
    case text
    case number
    case currency(String) // pass currency symbol, e.g. "€"
}

/// ViewModel for the DatePicker input
public final class TextFieldInputViewModel: BaseInputViewModel {
    
    /// Text input by user
    public var inputText: String
    
    /// Type of TextField input
    public var textType: TextFieldType
    
    /// Enable/disable interaction
    public var isEditable: Bool
    
    /// Closure called when date changes
    public var onTextChanged: ((String) -> Void)?
    
    public init(
        title: String,
        isEditable: Bool = true,
        placeholder: String? = nil,
        subtitle: String? = nil,
        inputText: String = "",
        textType: TextFieldType = .text,
        isMandatory: Bool = false
        
    ) {
        self.isEditable = isEditable
        self.inputText = inputText
        self.textType = textType
        
        super.init(title: title, placeholder: placeholder, subtitle: subtitle, isMandatory: isMandatory)
    }
}
