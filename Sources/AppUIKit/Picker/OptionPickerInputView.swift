//
//  OptionPickerInputView.swift
//  AppTemplate
//
//  Created by Miguel Solans on 01/04/2026.
//

import UIKit

public final class OptionPickerInputView: BaseInputView {

    // MARK: UI Components
    private let containerStackView = UIStackView()
    private let containerView = UIView()
    private let placeholderLabel = UILabel()
    private let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.down"))
    private let pickerView = UIPickerView()
    
    private var isExpanded = false
    
    public var inputViewModel: OptionInputViewModel {
        return super.viewModel as! OptionInputViewModel
    }

    // MARK: Init
    public init(viewModel: OptionInputViewModel, style: InputStyle = InputStyle()) {
        super.init(viewModel: viewModel, style: style)
        setupUI()
        updateUI()
        setupBindings()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    // MARK: Setup
    private func setupUI() {
        
        // Stack setup
        containerStackView.axis = .vertical
        containerStackView.spacing = 8
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Container styling
        containerView.backgroundColor = style.backgroundColor
        containerView.layer.cornerRadius = style.cornerRadius
        containerView.layer.borderWidth = style.borderWidth
        containerView.layer.borderColor = style.borderColor.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Button styling
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.font = style.placeholderFont
        placeholderLabel.text = viewModel.placeholder ?? ""
        
        // Chevron styling
        chevronImageView.tintColor = .systemGray
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // DatePicker setup
        pickerView.isHidden = true
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Add subviews to container
        containerView.addSubview(placeholderLabel)
        containerView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            placeholderLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            placeholderLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            placeholderLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            chevronImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        ])
        
        // Add container and picker to internal stack
        containerStackView.addArrangedSubview(containerView)
        containerStackView.addArrangedSubview(pickerView)
        
        // Add stack to userInputView
        userInputView.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: userInputView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: userInputView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: userInputView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: userInputView.bottomAnchor),
            
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(togglePicker))
        self.addGestureRecognizer(gesture)
    }
    
    // MARK: Update UI
    public override func updateUI() {
        super.updateUI()
        placeholderLabel.text = inputViewModel.selectedOption
    }
    
    // MARK: Actions
    @objc private func togglePicker() {
        guard inputViewModel.isEditable else { return }
        isExpanded.toggle()
        
        UIView.animate(withDuration: 0.25) {
            self.pickerView.isHidden = !self.isExpanded
            self.containerView.layer.borderColor = self.isExpanded ? self.style.selectedBorderColor.cgColor : self.style.borderColor.cgColor
            self.containerStackView.layoutIfNeeded()
        }
    }
}

extension OptionPickerInputView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return inputViewModel.options.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard row < inputViewModel.options.count else { return nil }
        return inputViewModel.options[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < inputViewModel.options.count else { return }
        
        let selected = inputViewModel.options[row]
        inputViewModel.selectedOption = selected
        inputViewModel.onSelectionChanged?()
        
        updateUI()
    }
}

#Preview("OptionPickerInputView") {
    
    let viewModel = OptionInputViewModel(title: "Title", isEditable: true, placeholder: "Placeholder", subtitle: "Subtitle", options: ["Option A", "Option B", "Option C"], selectedOption: "Option C", isMandatory: true);
    
    let inputView = OptionPickerInputView(viewModel: viewModel, style: InputStyle())
    
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

extension OptionPickerInputView {
    
    func setupBindings() {
        
        inputViewModel.onDataUpdated = { [weak self] in
            self?.pickerView.reloadAllComponents()
        }
    }
}
