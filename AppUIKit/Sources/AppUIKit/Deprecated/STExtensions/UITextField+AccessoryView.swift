//
//  UITextField+AccessoryView.swift
//  STCoreUI
//
//  Created by Miguel Solans on 03/03/2024.
//

import UIKit

extension UITextField {
    
    /// Add a input accessory view with button to keyboard when UITextView become first responder
    /// - Parameters:
    ///   - title: Button title
    ///   - target: Target class
    ///   - selector: Method invoked on tap
    func addInputAccessoryView(title: String, target: Any, selector: Selector) {
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0,
                                                  UIScreen.main.bounds.size.width, 44));
        let spacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector);

        toolbar.setItems([ spacing, barButton ], animated: true);
        
        self.inputAccessoryView = toolbar;
    }
}
