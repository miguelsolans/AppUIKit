//
//  SegmentedInputViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 30/03/2026.
//

import Foundation

public final class SegmentedInputViewModel: BaseInputViewModel {
    
    public var options: [String]
    
    public var selectedIndex: Int?
    
    public var isEditable: Bool
    
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
