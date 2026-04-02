//
//  TextFieldInputView.swift
//  AppTemplate
//
//  Created by Miguel Solans on 30/03/2026.
//

import UIKit

final class TextFieldInputView: BaseInputView {

    // MARK: UI Components
    private let containerStackView = UIStackView()
    private let horizontalStackView = UIStackView()
    private let containerView = UIView()
    private let textField = UITextField()
    private let currencyLabel = UILabel()
    
    public var inputViewModel: TextFieldInputViewModel {
        return super.viewModel as! TextFieldInputViewModel
    }

    // MARK: Init
    public init(viewModel: TextFieldInputViewModel, style: InputStyle = InputStyle()) {
        super.init(viewModel: viewModel, style: style)
        setupUI()
        updateUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    // MARK: Setup
    private func setupUI() {
        // Vertical stack
        containerStackView.axis = .vertical
        containerStackView.spacing = 8
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Container styling
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray4.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // TextField setup
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.borderStyle = .none
        textField.font = style.placeholderFont
        textField.placeholder = inputViewModel.placeholder
        textField.isUserInteractionEnabled = inputViewModel.isEditable
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField.inputAccessoryView = makeAccessoryView()
        
        switch inputViewModel.textType {
        case .text:
            textField.keyboardType = .default
        case .number:
            textField.keyboardType = .numberPad
        case .currency(let symbol):
            textField.keyboardType = .decimalPad
            currencyLabel.text = symbol
            currencyLabel.font = style.placeholderFont
            currencyLabel.textColor = .label
            currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        }
        
        containerView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            textField.topAnchor.constraint(equalTo: containerView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        // Horizontal stack: containerView + optional currencyLabel
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.alignment = .center
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalStackView.addArrangedSubview(containerView)
        if case .currency = inputViewModel.textType {
            horizontalStackView.addArrangedSubview(currencyLabel)
        }
        
        containerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        currencyLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        containerStackView.addArrangedSubview(horizontalStackView)
        
        userInputView.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: userInputView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: userInputView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: userInputView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: userInputView.bottomAnchor),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        // Tap to focus
        let gesture = UITapGestureRecognizer(target: self, action: #selector(focusTextField))
        containerView.addGestureRecognizer(gesture)
    }
    
    // MARK: Accessory view
    private func makeAccessoryView() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let label = UILabel()
        label.text = viewModel.title
        label.font = style.placeholderFont
        label.textColor = .label
        label.sizeToFit()
        
        let titleItem = UIBarButtonItem(customView: label)
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let done = UIBarButtonItem(title: "Done", style: .prominent, target: self, action: #selector(donePressed))
        
        toolbar.items = [flexible, titleItem, flexible, done]
        
        return toolbar
    }
    
    @objc private func donePressed() {
        textField.resignFirstResponder()
        containerView.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    // MARK: Update UI
    override func updateUI() {
        super.updateUI()
        textField.text = inputViewModel.inputText
    }
    
    // MARK: Actions
    @objc private func focusTextField() {
        guard inputViewModel.isEditable else { return }
        textField.becomeFirstResponder()
        containerView.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @objc private func textDidChange() {
        inputViewModel.inputText = textField.text ?? ""
        inputViewModel.onTextChanged?(inputViewModel.inputText)
    }
}

extension TextFieldInputView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor.systemGray4.cgColor
    }
}

#Preview("TextFieldInputView") {
    
    let viewModel = TextFieldInputViewModel(title: "Title", isEditable: true, placeholder: "Placeholder", subtitle: "Subtitle", inputText: "", textType: .currency("EUR"), isMandatory: true)
    
    let inputView = TextFieldInputView(viewModel: viewModel, style: InputStyle())
    
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
