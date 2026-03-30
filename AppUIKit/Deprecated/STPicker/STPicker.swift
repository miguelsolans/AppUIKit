//
//  STPicker.swift
//  ShowTime
//
//  Created by Miguel Solans on 27/02/2024.
//

import UIKit

public protocol STPickerDelegate : AnyObject {
    func didSelectPicker(_ pickerView: STPicker, withOption option: STPickerOption);
}

public class STPicker : STBaseInputView {
    
    public weak var delegate: STPickerDelegate?
    
    public var model: STPickerModel;
    
    fileprivate let placeholderLabel = UILabel();
    fileprivate let chevronImageView = UIImageView();
    
    public required init(title: String) {
        
        self.model = STPickerModel(title: title,
                                   options: [],
                                   placeholder: "",
                                   search: false,
                                   pickerStyle: .singleLabel);
        
        super.init(title: title);
    }
    
    public required init(model: STPickerModel) {
        self.model = model;
        super.init(title: model.title);
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public required init() {
        fatalError("init() has not been implemented")
    }
    
}

extension STPicker {
    override func style() {
        super.style()
        
        self.chevronImageView.image = UIImage(systemName: STCoreUIImages.ArrowRight)?
            .withRenderingMode(.alwaysTemplate);
        self.chevronImageView.tintColor = UIColor(named: STCoreUIColor.AccessibilityTintColor);
        
        self.chevronImageView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.placeholderLabel.text = self.model.placeholder;
        self.placeholderLabel.font = UIFont.systemFont(ofSize: STCoreUIFont.InputPlaceholderSize);
        self.placeholderLabel.textColor = UIColor(named: STCoreUIColor.UserInputColor);
        
        self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    override func layout() {
        super.layout()
        
        self.userInputView.addSubview(chevronImageView);
        self.userInputView.addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            self.userInputView.heightAnchor.constraint(equalToConstant: 50),
            
            self.placeholderLabel.leftAnchor.constraint(equalTo: self.userInputView.leftAnchor, constant: 12),
            self.placeholderLabel.rightAnchor.constraint(equalTo: self.userInputView.rightAnchor, constant: -12),
            self.placeholderLabel.centerYAnchor.constraint(equalTo: self.userInputView.centerYAnchor),
            
            self.chevronImageView.centerYAnchor.constraint(equalTo: self.userInputView.centerYAnchor),
            self.chevronImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -14)
        ]);
    }
    
    override func setupGestures() {
        let userInputViewTap = UITapGestureRecognizer(target: self, action: #selector(self.userInputViewTap(_:)));
        self.userInputView.addGestureRecognizer(userInputViewTap);
    }
}

extension STPicker {
    @objc func userInputViewTap(_ sender: UITapGestureRecognizer) {
        
        let rootViewController = self.delegate as? UIViewController
        
        let pickerViewController = STPickerViewController(options: self.model.options, withSearch: self.model.search, andStyle: self.model.pickerStyle);
        pickerViewController.delegate = self;
        
        rootViewController?.present(pickerViewController, animated: true);
    }
}

extension STPicker : STPickerViewControllerDelegate {
    func didSelectOption(_ option: STPickerOption) {
        self.placeholderLabel.text = option.label;
        
        self.model.selectedOption = option;
        
        self.delegate?.didSelectPicker(self, withOption: option);
    }
}

#Preview("STPicker") {
    let view = STPicker(title: "User input field title")
    
    view.showBottomLabelWithText("A support label underneath the user input", type: .successType)
    view.backgroundColor = UIColor(named: STCoreUIColor.AppBackgroundColor)
    
    return view;
}
