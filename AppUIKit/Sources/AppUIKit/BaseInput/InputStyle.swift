//
//  InputStyle.swift
//  AppTemplate
//
//  Created by Miguel Solans on 29/03/2026.
//

import UIKit

/// `InputStyle` defines the visual appearance of input components.
/// It includes configuration for colors, fonts, and layout properties
/// such as border and corner radius.
///
///  Example Usage:
///  ```swift
///  let style = InputStyle(
///      backgroundColor: .white,
///      borderColor: .lightGray,
///      selectedBorderColor: .blue
///  )
///  ```
public struct InputStyle {

    // MARK: Colors
    
    /// The color of the component background
    public var backgroundColor: UIColor
    
    /// The color of the component border
    public var borderColor: UIColor
    
    /// The color of the component border when in focus
    public var selectedBorderColor: UIColor
    
    /// The title color
    public var titleColor: UIColor
    
    /// The bottom label color
    public var bottomLabelColor: UIColor
    
    /// The success label color
    public var successColor: UIColor
    
    /// The warning label color
    public var warningColor: UIColor
    
    /// The error label color
    public var errorColor: UIColor

    // MARK: Fonts
    
    /// The component title label font
    public var titleFont: UIFont
    
    /// The component user input placeholder font
    public var placeholderFont: UIFont
    
    /// The component bottom label label font
    public var bottomLabelFont: UIFont

    // MARK: Spacing
    
    /// The radius of component border
    public var cornerRadius: CGFloat
    
    /// The width of the component border
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
