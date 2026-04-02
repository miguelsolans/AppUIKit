//
//  ColorPickerInputView.swift
//  AppTemplate
//
//  Created by Miguel Solans on 02/04/2026.
//

import UIKit

final class ColorPickerInputView: BaseInputView {

    // MARK: UI
    private let containerView = UIView()
    private let horizontalStackView = UIStackView()
    private let placeholderLabel = UILabel()
    private let colorPreviewView = UIView()

    public var inputViewModel: ColorPickerInputViewModel {
        return super.viewModel as! ColorPickerInputViewModel
    }

    // MARK: Init
    public init(viewModel: ColorPickerInputViewModel, style: InputStyle = InputStyle()) {
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
        // Container styling
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = style.borderColor.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false

        // Label
        placeholderLabel.font = style.placeholderFont
        placeholderLabel.numberOfLines = 0
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

        // Color preview
        colorPreviewView.layer.cornerRadius = 10
        colorPreviewView.layer.borderWidth = 1
        colorPreviewView.layer.borderColor = UIColor.systemGray4.cgColor
        colorPreviewView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            colorPreviewView.widthAnchor.constraint(equalToConstant: 30),
            colorPreviewView.heightAnchor.constraint(equalToConstant: 30)
        ])

        // Stack
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 12
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

        horizontalStackView.addArrangedSubview(placeholderLabel)
        horizontalStackView.addArrangedSubview(colorPreviewView)

        placeholderLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        placeholderLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        colorPreviewView.setContentHuggingPriority(.required, for: .horizontal)
        colorPreviewView.setContentCompressionResistancePriority(.required, for: .horizontal)

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

        // Tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(openColorPicker))
        containerView.addGestureRecognizer(tap)
    }

    // MARK: Update UI
    override func updateUI() {
        super.updateUI()
        placeholderLabel.text = inputViewModel.placeholder
        colorPreviewView.backgroundColor = inputViewModel.selectedColor
    }

    // MARK: Actions
    @objc private func openColorPicker() {
        guard inputViewModel.isEditable else { return }

        let picker = UIColorPickerViewController()
        picker.selectedColor = inputViewModel.selectedColor
        picker.delegate = self

        parentViewController?.present(picker, animated: true)
    }
}

// MARK: - UIColorPicker Delegate
extension ColorPickerInputView: UIColorPickerViewControllerDelegate {

    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        inputViewModel.selectedColor = color
        colorPreviewView.backgroundColor = color
    }
}

#Preview("ColorPickerInputView") {
    
    let viewModel = ColorPickerInputViewModel(
        title: "Favorite Color",
        selectedColor: .systemBlue,
        placeholder: "Choose a color",
        subtitle: "Pick your preferred theme color",
        isMandatory: true
    )
    
    let inputView = ColorPickerInputView(
        viewModel: viewModel,
        style: InputStyle()
    )
    
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

extension UIColor {
    
    convenience init?(hexString: String) {
            var hex = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
                .uppercased()
            
            if hex.hasPrefix("#") {
                hex.removeFirst()
            }
            
            guard hex.count == 6 || hex.count == 8 else { return nil }
            
            var value: UInt64 = 0
            guard Scanner(string: hex).scanHexInt64(&value) else { return nil }
            
            let red, green, blue, alpha: CGFloat
            
            if hex.count == 8 {
                red = CGFloat((value & 0xFF000000) >> 24) / 255
                green = CGFloat((value & 0x00FF0000) >> 16) / 255
                blue = CGFloat((value & 0x0000FF00) >> 8) / 255
                alpha = CGFloat(value & 0x000000FF) / 255
            } else {
                red = CGFloat((value & 0xFF0000) >> 16) / 255
                green = CGFloat((value & 0x00FF00) >> 8) / 255
                blue = CGFloat(value & 0x0000FF) / 255
                alpha = 1.0
            }
            
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
    
    func toHexString(includeAlpha: Bool = false) -> String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        if includeAlpha {
            return String(
                format: "#%02X%02X%02X%02X",
                Int(round(red * 255)),
                Int(round(green * 255)),
                Int(round(blue * 255)),
                Int(round(alpha * 255))
            )
        } else {
            return String(
                format: "#%02X%02X%02X",
                Int(round(red * 255)),
                Int(round(green * 255)),
                Int(round(blue * 255))
            )
        }
    }
}
