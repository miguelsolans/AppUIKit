//
//  ButtonStyle.swift
//  AppUIKit
//
//  Created by Miguel Solans on 04/04/2026.
//

import UIKit

public struct ButtonStyle {
    
    public var backgroundColor: UIColor
    
    public var titleColor: UIColor
    
    public var borderColor: UIColor
    
    public var disabledBackgroundColor: UIColor
    
    public var disabledTitleColor: UIColor
    
    public var cornerRadius: CGFloat
    
    public var borderWidth: CGFloat
    
    public var font: UIFont
    
    public var contentInsets: NSDirectionalEdgeInsets
    
    public init(
        backgroundColor: UIColor = UIColor.systemBlue,
        titleColor: UIColor = UIColor.white,
        borderColor: UIColor = UIColor.systemBlue,
        disabledBackgroundColor: UIColor = UIColor.systemGray4,
        disabledTitleColor: UIColor = UIColor.gray,
        cornerRadius: CGFloat = 8,
        borderWidth: CGFloat = 1,
        font: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold),
        contentInsets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
    ) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.borderColor = borderColor
        self.disabledBackgroundColor = disabledBackgroundColor
        self.disabledTitleColor = disabledTitleColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.font = font
        self.contentInsets = contentInsets
    }
}

public extension UIButton {
    
    func apply(style: ButtonStyle, title: String? = nil) {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title ?? self.currentTitle
        configuration.background.cornerRadius = style.cornerRadius
        configuration.contentInsets = style.contentInsets
        
        self.configuration = configuration
        self.layer.borderWidth = style.borderWidth
        self.layer.borderColor = style.borderColor.cgColor
        self.titleLabel?.font = style.font
        
        configurationUpdateHandler = { button in
            var updatedConfiguration = button.configuration
            
            if button.isEnabled {
                updatedConfiguration?.background.backgroundColor = style.backgroundColor
                updatedConfiguration?.baseForegroundColor = style.titleColor
            } else {
                updatedConfiguration?.background.backgroundColor = style.disabledBackgroundColor
                updatedConfiguration?.baseForegroundColor = style.disabledTitleColor
            }
            
            button.configuration = updatedConfiguration
        }
        
        setNeedsUpdateConfiguration()
    }
}
