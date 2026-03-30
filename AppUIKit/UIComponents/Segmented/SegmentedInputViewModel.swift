//
//  SegmentedInputViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 30/03/2026.
//

import Foundation

/// ViewModel for an OptionPicker (SegmentedControl)
public final class SegmentedInputViewModel: BaseInputViewModel {
    
    /// Available options for the user to select
    public var options: [String]
    
    /// Currently selected index
    public var selectedIndex: Int?
    
    /// Enable/disable interaction
    public var isEditable: Bool
    
    /// Closure called when selection changes
    public var onSelectionChanged: ((Int?) -> Void)?
    
    public init(
        title: String,
        options: [String],
        selectedIndex: Int? = nil,
        isEditable: Bool = true,
        placeholder: String? = nil,
        subtitle: String? = nil,
        isMandatory: Bool = false
    ) {
        self.options = options
        self.selectedIndex = selectedIndex
        self.isEditable = isEditable
        super.init(title: title, placeholder: placeholder, subtitle: subtitle, isMandatory: isMandatory)
    }
}
