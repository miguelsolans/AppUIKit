//
//  SwitchInputView.swift
//  AppTemplate
//
//  Created by Miguel Solans on 02/04/2026.
//

import UIKit

public final class SwitchInputView: BaseInputView {

    // MARK: UI
    private let containerView = UIView()
    private let horizontalStackView = UIStackView()
    private let placeholderLabel = UILabel()
    private let toggleSwitch = UISwitch()

    public var inputViewModel: SwitchInputViewModel {
        return super.viewModel as! SwitchInputViewModel
    }

    // MARK: Init
    public init(viewModel: SwitchInputViewModel, style: InputStyle = InputStyle()) {
        super.init(viewModel: viewModel, style: style)
        setupUI()
        updateUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: Setup
    private func setupUI() {
        containerView.backgroundColor = style.backgroundColor
        containerView.layer.cornerRadius = style.cornerRadius
        containerView.layer.borderWidth = style.borderWidth
        containerView.layer.borderColor = style.borderColor.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false

        // Label
        placeholderLabel.font = style.placeholderFont
        placeholderLabel.numberOfLines = 0
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

        // Switch
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)

        // Stack
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 12
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

        horizontalStackView.addArrangedSubview(placeholderLabel)
        horizontalStackView.addArrangedSubview(toggleSwitch)

        placeholderLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        placeholderLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        toggleSwitch.setContentHuggingPriority(.required, for: .horizontal)
        toggleSwitch.setContentCompressionResistancePriority(.required, for: .horizontal)

        // Layout
        containerView.addSubview(horizontalStackView)
        userInputView.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: userInputView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: userInputView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: userInputView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: userInputView.bottomAnchor),

            horizontalStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            horizontalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            horizontalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            horizontalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),

            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }

    // MARK: Update UI
    public override func updateUI() {
        super.updateUI()
        placeholderLabel.text = inputViewModel.placeholder
        toggleSwitch.isOn = inputViewModel.isOn
        toggleSwitch.isEnabled = inputViewModel.isEditable
    }

    // MARK: Actions
    @objc private func switchChanged() {
        inputViewModel.isOn = toggleSwitch.isOn
        inputViewModel.onValueChanged?(toggleSwitch.isOn)
    }
}

#Preview("SwitchInputView") {
    
    let viewModel = SwitchInputViewModel(title: "Title", isOn: true, isEditable: false, placeholder: "Placeholder", subtitle: "Subtitle", isMandatory: false)
    
    let inputView = SwitchInputView(viewModel: viewModel, style: InputStyle())
    
    inputView.showBottomLabel("Error label", type: .errorType)
    
    let vc = UIViewController()
    vc.view.backgroundColor = .systemBackground
    
    inputView.translatesAutoresizingMaskIntoConstraints = false
    vc.view.addSubview(inputView)
    
    NSLayoutConstraint.activate([
        inputView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
        inputView.centerYAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.centerYAnchor),
        inputView.leadingAnchor.constraint(greaterThanOrEqualTo: vc.view.leadingAnchor, constant: 16),
        inputView.trailingAnchor.constraint(lessThanOrEqualTo: vc.view.trailingAnchor, constant: -20),
        inputView.widthAnchor.constraint(equalToConstant: 250)
    ])
    
    return vc
}
