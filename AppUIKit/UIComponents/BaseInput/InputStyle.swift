//
//  InputStyle.swift
//  AppTemplate
//
//  Created by Miguel Solans on 29/03/2026.
//

import UIKit

public struct InputStyle {

    // MARK: Colors
    public var backgroundColor: UIColor
    public var borderColor: UIColor
    public var selectedBorderColor: UIColor
    public var titleColor: UIColor
    public var bottomLabelColor: UIColor
    public var successColor: UIColor
    public var warningColor: UIColor
    public var errorColor: UIColor

    // MARK: Fonts
    public var titleFont: UIFont
    public var placeholderFont: UIFont
    public var bottomLabelFont: UIFont

    // MARK: Spacing
    public var cornerRadius: CGFloat
    public var borderWidth: CGFloat

    public init(
        backgroundColor: UIColor = .secondarySystemBackground,
        borderColor: UIColor = .systemGray4,
        selectedBorderColor: UIColor = .systemBlue,
        titleColor: UIColor = .label,
        bottomLabelColor: UIColor = .secondaryLabel,
        successColor: UIColor = .systemGreen,
        warningColor: UIColor = .systemOrange,
        errorColor: UIColor = .systemRed,
        titleFont: UIFont = .systemFont(ofSize: 14, weight: .regular),
        placeholderFont: UIFont = .systemFont(ofSize: 14, weight: .medium),
        bottomLabelFont: UIFont = .systemFont(ofSize: 12),
        cornerRadius: CGFloat = 6,
        borderWidth: CGFloat = 1
    ) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.selectedBorderColor = selectedBorderColor
        self.titleColor = titleColor
        self.bottomLabelColor = bottomLabelColor
        self.successColor = successColor
        self.warningColor = warningColor
        self.errorColor = errorColor
        self.titleFont = titleFont
        self.placeholderFont = placeholderFont
        self.bottomLabelFont = bottomLabelFont
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
    }
}
