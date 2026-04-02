//
//  DatePickerInputView.swift
//  AppTemplate
//
//  Created by Miguel Solans on 29/03/2026.
//

import UIKit

public final class DatePickerInputView: BaseInputView {

    // MARK: UI Components
    private let containerStackView = UIStackView()
    private let containerView = UIView()
    private let placeholderLabel = UILabel()
    private let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.down"))
    private let calendarImageView = UIImageView(image: UIImage(systemName: "calendar"))
    private let datePicker = UIDatePicker()
    
    private var isExpanded = false
    
    public var inputViewModel: DatePickerInputViewModel {
        return super.viewModel as! DatePickerInputViewModel
    }

    // MARK: Init
    public init(viewModel: DatePickerInputViewModel, style: InputStyle = InputStyle()) {
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
        
        // Stack setup
        containerStackView.axis = .vertical
        containerStackView.spacing = 8
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Container styling
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray4.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Button styling
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.font = style.placeholderFont
        placeholderLabel.text = viewModel.placeholder ?? ""
        
        // Chevron styling
        chevronImageView.tintColor = .systemGray
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Calendar styling
        calendarImageView.tintColor = .systemGray
        calendarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // DatePicker setup
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.isHidden = true
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        // Add subviews to container
        containerView.addSubview(calendarImageView)
        containerView.addSubview(placeholderLabel)
        containerView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            calendarImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            calendarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            
            placeholderLabel.leadingAnchor.constraint(equalTo: calendarImageView.leadingAnchor, constant: 36),
            placeholderLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            placeholderLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            placeholderLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            chevronImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        ])
        
        // Add container and picker to internal stack
        containerStackView.addArrangedSubview(containerView)
        containerStackView.addArrangedSubview(datePicker)
        
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
        placeholderLabel.text = inputViewModel.formattedDate()
        datePicker.date = inputViewModel.selectedDate
        datePicker.minimumDate = inputViewModel.minDate
        datePicker.maximumDate = inputViewModel.maxDate
    }
    
    // MARK: Actions
    @objc private func togglePicker() {
        guard inputViewModel.isEditable else { return }
        isExpanded.toggle()
        
        UIView.animate(withDuration: 0.25) {
            self.datePicker.isHidden = !self.isExpanded
            self.containerView.layer.borderColor = self.isExpanded ? UIColor.systemBlue.cgColor : UIColor.systemGray4.cgColor
            self.containerStackView.layoutIfNeeded()
        }
    }
    
    @objc private func dateChanged() {
        inputViewModel.selectedDate = datePicker.date
        placeholderLabel.text = inputViewModel.formattedDate()
    }
}

#Preview("DatePickerInputView") {
    
    let viewModel = DatePickerInputViewModel(title: "Title", selectedDate: Date(), isEditable: true, placeholder: "Placeholder", subtitle: "Subtitle", isMandatory: true)
    
    let inputView = DatePickerInputView(viewModel: viewModel, style: InputStyle())
    
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
