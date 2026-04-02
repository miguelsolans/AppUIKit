//
//  STPickerDoubleLabelTableViewCell.swift
//  STCoreUI
//
//  Created by Miguel Solans on 02/03/2024.
//

import UIKit

public class STPickerDoubleLabelTableViewCell : UITableViewCell {
    
    /// Properties
    public static var reusableIdentifier = "DataPickerDoubleLabel";
    
    /// UI Components
    fileprivate let stackView = UIStackView();
    fileprivate let label = UILabel();
    fileprivate let subLabel = UILabel();
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.style();
        self.layout();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
}

// MARK: - Layout and Styling
extension STPickerDoubleLabelTableViewCell {
    func style() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false;
        self.stackView.axis = .vertical;
        
        self.label.font = UIFont.boldSystemFont(ofSize: STCoreUIFont.InputTitleSize)
        self.subLabel.font = UIFont.systemFont(ofSize: STCoreUIFont.InputPlaceholderSize)
        self.subLabel.lineBreakMode = .byWordWrapping;
        self.subLabel.numberOfLines = 0
        
        
    }
    
    func layout() {
        self.stackView.addArrangedSubview(label);
        self.stackView.addArrangedSubview(subLabel);
        
        self.addSubview(stackView);
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 4)
        ]);
    }
}

public extension STPickerDoubleLabelTableViewCell {
    func updateWithLabel(text: String, andSubText subText: String) {
        self.label.text = text;
        self.subLabel.text = subText;
    }
}

#Preview("STPickerDoubleLabelTableViewCell") {
    let view = STPickerDoubleLabelTableViewCell(style: .default, reuseIdentifier: STPickerDoubleLabelTableViewCell.reusableIdentifier);
    
    view.updateWithLabel(text: "First Label", andSubText: "Smaller and probably bigger text");
    
    return view;
}
