//
//  BaseInputView.swift.swift
//  AppTemplate
//
//  Created by Miguel Solans on 29/03/2026.
//

import UIKit

// MARK: - Base Input View
open class BaseInputView: UIView {
    
    // MARK: Properties
    public let viewModel: BaseInputViewModel
    public var style: InputStyle
    
    // MARK: UI Components
    fileprivate let stackView = UIStackView()
    fileprivate let titleLabel = UILabel()
    fileprivate let bottomLabel = UILabel()
    public let userInputView = UIView() // Subclasses replace with real input
    
    // MARK: Init
    public init(viewModel: BaseInputViewModel, style: InputStyle = InputStyle()) {
        self.viewModel = viewModel
        self.style = style
        super.init(frame: .zero)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        self.viewModel = BaseInputViewModel(title: "")
        self.style = InputStyle()
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.viewModel = BaseInputViewModel(title: "")
        self.style = InputStyle()
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        styleView()
        layoutComponents()
        setupGestures()
        updateUI()
    }
    
    // MARK: - Overridable Styling
    @objc open func styleView() {
        // Title label
        titleLabel.textAlignment = .left
        titleLabel.font = style.titleFont
        titleLabel.textColor = style.titleColor
        
        // Bottom label
        bottomLabel.font = style.bottomLabelFont
        bottomLabel.numberOfLines = 0
        bottomLabel.alpha = 0
        
        // StackView
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc open func layoutComponents() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(userInputView)
        stackView.addArrangedSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }
    
    @objc open func setupGestures() {
        // Subclasses can override if needed
    }
    
    // MARK: - Bottom Label Handling
    public func showBottomLabel(_ text: String, type: BottomLabelType) {
        bottomLabel.text = text
        
        switch type {
        case .successType: bottomLabel.textColor = style.successColor
        case .warningType: bottomLabel.textColor = style.warningColor
        case .errorType: bottomLabel.textColor = style.errorColor
        case .informativeType: bottomLabel.textColor = style.bottomLabelColor
        }
        
        UIView.animate(withDuration: 0.25) {
            self.bottomLabel.alpha = 1
        }
    }
    
    public func hideBottomLabel() {
        UIView.animate(withDuration: 0.25) {
            self.bottomLabel.text = ""
            self.bottomLabel.alpha = 0
        }
    }
    
    // MARK: - Update UI
    @objc open func updateUI() {
        // Mandatory marker
        if viewModel.isMandatory {
            titleLabel.text = "\(viewModel.title) *"
        } else {
            titleLabel.text = viewModel.title
            userInputView.layer.borderColor = style.borderColor.cgColor
        }
        
        if viewModel.isEnabled {
            self.alpha = 1
        } else {
            self.alpha = 0.5;
        }
    }
}

// MARK: - Bottom Label Type Enum
public enum BottomLabelType {
    case successType
    case warningType
    case errorType
    case informativeType
}

// MARK: - Swift Macros
#Preview("BaseInputView") {
    
    let viewModel = BaseInputViewModel(title: "Title", isMandatory: true)
    let style = InputStyle()
    let inputView = BaseInputView(viewModel: viewModel, style: style)
    
    inputView.showBottomLabel("Hello world", type: .errorType)
    
    let vc = UIViewController()
    vc.view.backgroundColor = .systemBackground
    
    inputView.translatesAutoresizingMaskIntoConstraints = false
    vc.view.addSubview(inputView)
    
    NSLayoutConstraint.activate([
        inputView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
        inputView.centerYAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.centerYAnchor),
        inputView.leadingAnchor.constraint(greaterThanOrEqualTo: vc.view.leadingAnchor, constant: 16),
        inputView.trailingAnchor.constraint(lessThanOrEqualTo: vc.view.trailingAnchor, constant: -16)
    ])
    
    return vc
}
