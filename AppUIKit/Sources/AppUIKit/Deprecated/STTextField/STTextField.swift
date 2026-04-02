//
//  STTextField.swift
//  ShowTime
//
//  Created by Miguel Solans on 25/02/2024.
//

import UIKit

public class STTextField: STBaseInputView {
    
    fileprivate let placeholder: String;
    
    public let textField = UITextField();
    
    public required init(title: String) {
        self.placeholder = "";
        super.init(title: title);
    }
    
    public required init(title: String, placeholder: String) {
        self.placeholder = placeholder;
        super.init(title: title);
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.placeholder = "";
        super.init(coder: aDecoder);
    }
    
    public required init(frame: CGRect) {
        self.placeholder = ""
        super.init()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}

extension STTextField {
    
    func setupDelegates() {
        self.textField.delegate = self;
    }
    
    override func style() {
        super.style()
        
        self.textField.placeholder = self.placeholder
        self.textField.attributedPlaceholder = NSAttributedString(string: self.placeholder, attributes: [
            .font: UIFont.systemFont(ofSize: STCoreUIFont.InputPlaceholderSize),
            .foregroundColor: UIColor(named: STCoreUIColor.UserInputColor)
        ]);
        self.textField.font = UIFont.systemFont(ofSize: STCoreUIFont.UserInputSize)
        self.textField.textColor = UIColor(named: STCoreUIColor.UserInputColor)
        self.textField.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    override func layout() {
        super.layout()
        
        self.userInputView.addSubview(textField);
        
        NSLayoutConstraint.activate([
            self.userInputView.heightAnchor.constraint(equalToConstant: 50),
            self.textField.leftAnchor.constraint(equalTo: userInputView.leftAnchor, constant: 12),
            self.textField.rightAnchor.constraint(equalTo: userInputView.rightAnchor, constant: -12),
            self.textField.centerYAnchor.constraint(equalTo: userInputView.centerYAnchor),
        ]);
    }
}

extension STTextField : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true;
    }
}

public extension STTextField {
    func getText() -> String {
        return self.textField.text ?? "";
    }
    
    func isEmpty() -> Bool {
        return self.textField.text?.isEmpty ?? true
    }
}

#Preview("STTextField") {
    let view = STTextField(title: "Title", placeholder: "Field text goes here")
    view.showBottomLabelWithText("Error", type: .successType)
    view.backgroundColor = UIColor(named: STCoreUIColor.AppBackgroundColor)
    
    return view;
}
