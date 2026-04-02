//
//  ColorPickerInputViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 02/04/2026.
//

import UIKit

public final class ColorPickerInputViewModel: BaseInputViewModel {

    public var selectedColor: UIColor {
        didSet {
            onColorChanged?(selectedColor)
        }
    }

    public var isEditable: Bool

    public var onColorChanged: ((UIColor) -> Void)?

    public init(
        title: String,
        selectedColor: UIColor = .systemBlue,
        isEditable: Bool = true,
        placeholder: String? = nil,
        subtitle: String? = nil,
        isMandatory: Bool = false
    ) {
        self.selectedColor = selectedColor
        self.isEditable = isEditable

        super.init(
            title: title,
            placeholder: placeholder,
            subtitle: subtitle,
            isMandatory: isMandatory
        )
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let vc = parentResponder as? UIViewController {
                return vc
            }
        }
        return nil
    }
}
