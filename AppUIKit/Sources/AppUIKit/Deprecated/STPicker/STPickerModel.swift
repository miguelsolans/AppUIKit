//
//  STPickerModel.swift
//  STCoreUI
//
//  Created by Miguel Solans on 02/03/2024.
//

import Foundation

public struct STPickerOption {
    
    public let id: String
    public let label: String
    public let subLabel: String
    
    public init(id: String, label: String, subLabel: String) {
        self.id = id
        self.label = label
        self.subLabel = subLabel
    }
    
}

public class STPickerModel : STBaseInputModel{
    
    public var options: [STPickerOption];
    public var placeholder: String
    public var search: Bool
    public var pickerStyle: STPickerStyle
    public var selectedOption: STPickerOption?
    
    public init(title: String, options: [STPickerOption], placeholder: String, search: Bool, pickerStyle: STPickerStyle) {
        self.options = options
        self.placeholder = placeholder
        self.search = search
        self.pickerStyle = pickerStyle
        
        super.init(title: title)
    }
    
    public func getSelectedOption() -> STPickerOption {
        guard let selectedOption = selectedOption else {
            fatalError("Attempted to force unwrap a nil selectedOption")
        }
        
        return selectedOption;
    }
}

