//
//  STBaseInputModel.swift
//  STCoreUI
//
//  Created by Miguel Solans on 02/03/2024.
//

import Foundation

public class STBaseInputModel {
    let title: String;
    let isMandatory: Bool = false;
    
    public init(title: String) {
        self.title = title
    }
}
