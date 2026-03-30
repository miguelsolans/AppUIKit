//
//  STBaseInputView.swift
//  ShowTime
//
//  Created by Miguel Solans on 27/02/2024.
//

import UIKit

/// `STBaseInputView` is a base class for creating customizable user input components with a consistent design.
/// It provides a structured layout for displaying a title, user input view, and a bottom label.
///
///  Example Usage:
///  ```swift
///  let view = STBaseInputView(title: "Title")
///  view.showBottomLabelWithText("Error", type: .successType)
///  view.backgroundColor = UIColor(named: STCoreUIColor.AppBackgroundColor)
///  ```
public class STBaseInputView: UIView {
    
    // MARK: - Properties
    /// A string representing the title of the UI component.
    public let title: String;
    
    // MARK: - UI Components
    /// A stack view containing all UI component views.
    fileprivate let stackView = UIStackView();
    /// A label displaying the component title.
    fileprivate let titleLabel = UILabel();
    /// A label at the bottom of the user input component for additional information.
    fileprivate let bottomLabel = UILabel();
    /// A container designed to hold the user input component within `STBaseInputView`. 
    /// This property is crucial for inherited classes as it provides the necessary structure to display the appropriate user input control.
    public let userInputView = UIView();
    
    /// Initializes the `STBaseInputView` with the specified title.
    /// - Parameter title: A string representing the title of the UI component.
    required init(title: String) {
        
        self.title = title;
        
        super.init(frame: CGRect.zero);
        
        self.commonInit()
    }
    
    /// Initializes the `STBaseInputView` with an empty title.
    /// - Parameter title:
    required init() {
        
        self.title = "";
        
        super.init(frame: CGRect.zero);
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = "";
        super.init(coder: aDecoder);
        
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        self.style()
        self.layout();
        self.setupGestures();
    }
}

// MARK: - Overridable methods
extension STBaseInputView {
    
    /// Override this method to apply custom styles to the `STBaseInputView`.
    @objc func style() {
        
        self.titleLabel.text = self.title;
        self.titleLabel.textAlignment = .left
        self.titleLabel.font = UIFont.systemFont(ofSize: STCoreUIFont.InputTitleSize);
        self.titleLabel.textColor = UIColor(named: STCoreUIColor.InputTitleColor);
        
        self.userInputView.layer.borderWidth = 1.0
        self.userInputView.layer.borderColor = UIColor(named: STCoreUIColor.InputBorderColor)?.cgColor;
        self.userInputView.layer.cornerRadius = 6
        self.userInputView.translatesAutoresizingMaskIntoConstraints = false;
        self.userInputView.backgroundColor = UIColor(named: STCoreUIColor.InputBackgroundColor)
        
        
        self.bottomLabel.font = UIFont.systemFont(ofSize: STCoreUIFont.InputBottomSize)
        self.bottomLabel.numberOfLines = 0;
        self.bottomLabel.alpha = 0;
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false;
        self.stackView.axis = .vertical
        self.stackView.spacing = 12;
    }
    
    /// Override this method to customize the layout of the UI components.
    @objc func layout() {
        
        self.addSubview(stackView);
        
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(userInputView)
        self.stackView.addArrangedSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]);
    }
    
    /// Override this method to set up gestures for the `STBaseInputView`.
    @objc func setupGestures() {
        
    }
}

// MARK: - Public methods
extension STBaseInputView {
    /// Updates the bottom label with the specified text and type (error, success, or informative).
    /// - Parameter text: A string representing the text to be visible in the bottom
    /// - Parameter type: A enum representing nature of the message
    public func showBottomLabelWithText(_ text: String, type: BottomLabelType) {
        self.bottomLabel.text = text;
        
        switch type {
        case .successType:
            self.bottomLabel.textColor = UIColor(named: STCoreUIColor.SuccessColor)
            break;
        case .warningType:
            self.bottomLabel.textColor = UIColor(named: STCoreUIColor.WarningColor)
            break;
        case .errorType:
            self.bottomLabel.textColor = UIColor(named: STCoreUIColor.ErrorColor)
            break;
        case .informativeType:
            self.bottomLabel.textColor = UIColor(named: STCoreUIColor.InputTitleColor)
            break;
        }
        
        UIView.animate(withDuration: 0.25) {
            self.bottomLabel.alpha = 1
        }
    }
    
    public func hideBottomLabel() {
        UIView.animate(withDuration: 0.25) {
            self.bottomLabel.text = "";
            self.bottomLabel.alpha = 0
        }
    }
}

// MARK: - Swift Macros
#Preview("STBaseInput") {
    let view = STBaseInputView(title: "Title")
    view.showBottomLabelWithText("Error", type: .successType)
    view.backgroundColor = UIColor(named: STCoreUIColor.AppBackgroundColor)
    
    return view;
}

