//
//  STTextView.swift
//  STCoreUI
//
//  Created by Miguel Solans on 02/03/2024.
//

import UIKit

public class STTextView: STBaseInputView {
    
    let model: STBaseInputModel
    
    public let textView = UITextView();
    
    required init(title: String) {
        self.model = STBaseInputModel(title: title)
        super.init(title: title);
    }
    
    public init(model: STBaseInputModel) {
        self.model = model;
        
        super.init(title: model.title)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension STTextView {
    func setupDelegates() { }
    
    override func style() {
        super.style()
        
        self.textView.backgroundColor = .clear;
        self.textView.font = UIFont.systemFont(ofSize: STCoreUIFont.UserInputSize)
        self.textView.textColor = UIColor(named: STCoreUIColor.UserInputColor)
        self.textView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.textView.addInputAccessoryView(title: "OK", target: self, selector: #selector(self.doneButtonTapped(_:)))
    }
    
    override func layout() {
        super.layout()
        
        self.userInputView.addSubview(textView);
        
        NSLayoutConstraint.activate([
            self.userInputView.heightAnchor.constraint(equalToConstant: 200),
            self.textView.topAnchor.constraint(equalTo: self.userInputView.topAnchor),
            self.textView.leftAnchor.constraint(equalTo: userInputView.leftAnchor, constant: 12),
            self.textView.rightAnchor.constraint(equalTo: userInputView.rightAnchor, constant: -12),
            self.textView.centerYAnchor.constraint(equalTo: userInputView.centerYAnchor),
        ]);
    }
}

extension STTextView {
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.textView.resignFirstResponder()
    }
}

#Preview("STTextView") {
    let view = STTextView(model: STBaseInputModel(title: "Title"))
    view.showBottomLabelWithText("Error", type: .successType)
    view.backgroundColor = UIColor(named: STCoreUIColor.AppBackgroundColor)
    
    return view;
}

