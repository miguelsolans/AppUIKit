//
//  SwitchInputViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 02/04/2026.
//

import Foundation

public final class SwitchInputViewModel: BaseInputViewModel {

    public var isOn: Bool {
        didSet {
            onValueChanged?(isOn)
        }
    }

    public var isEditable: Bool

    public var onValueChanged: ((Bool) -> Void)?

    public init(
        title: String,
        isOn: Bool = false,
        isEditable: Bool = true,
        placeholder: String? = nil,
        subtitle: String? = nil,
        isMandatory: Bool = false
    ) {
        self.isOn = isOn
        self.isEditable = isEditable

        super.init(
            title: title,
            placeholder: placeholder,
            subtitle: subtitle,
            isMandatory: isMandatory
        )
    }
}
