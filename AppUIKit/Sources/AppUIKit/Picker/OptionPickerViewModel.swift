//
//  OptionPickerViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 01/04/2026.
//

import Foundation

public final class OptionInputViewModel: BaseInputViewModel {
    
    public var options: [String] {
        didSet {
            onDataUpdated?()
        }
    }
    
    var onDataUpdated: (() -> Void)?
    
    public var selectedOption: String?
    
    public var isEditable: Bool
    
    public var onSelectionChanged: (() -> Void)?
    
    public init(
        title: String,
        isEditable: Bool = true,
        placeholder: String? = nil,
        subtitle: String? = nil,
        options: [String],
        selectedOption: String? = nil,
        isMandatory: Bool = false
    ) {
        self.isEditable = isEditable
        self.options = options
        self.selectedOption = selectedOption
        
        super.init(
            title: title,
            placeholder: placeholder,
            subtitle: subtitle,
            isMandatory: isMandatory
        )
    }
}
