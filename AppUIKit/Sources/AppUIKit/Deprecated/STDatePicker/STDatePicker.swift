//
//  STDatePicker.swift
//  STCoreUI
//
//  Created by Miguel Solans on 03/03/2024.
//

import UIKit

public class STDatePicker: STTextField {
    fileprivate let datePicker = UIDatePicker()
    public required init(title: String) {
        super.init(title: title)
    }
    
    public required init(title: String, placeholder: String) {
        super.init(title: title, placeholder: placeholder)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public required init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
}

extension STDatePicker {

    override func style() {
        super.style()
        self.textField.tintColor = .clear;
        self.textField.inputView = datePicker;
        
        self.datePicker.preferredDatePickerStyle = .wheels;
        self.datePicker.datePickerMode = .date;
        
        self.textField.addInputAccessoryView(title: "OK", target: self, selector: #selector(self.doneButtonTapped(_:)))
    }
    
    override func layout() {
        super.layout()
    }
}

extension STDatePicker {
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.textField.text = self.datePicker.date.getFormattedDate();
        self.textField.resignFirstResponder();
    }
}

public extension STDatePicker {
    func getFormattedDate() -> String {
        return self.datePicker.date.getFormattedDate()
    }
}
