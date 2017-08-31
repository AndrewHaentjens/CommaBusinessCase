//
//  StringExtensions.swift
//  CommaBusinessCaseApp
//
//  Created by Andrew Haentjens on 27/08/17.
//  Copyright © 2017 Comma. All rights reserved.
//

import Foundation

private class Localizator {
    
    static let sharedInstance = Localizator()
    
    lazy var localizableDictionary: NSDictionary! = {
        if let path = Bundle.main.path(forResource: "Strings", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        fatalError("Localizable file NOT found")
    }()
    
    func localize(string: String) -> String {
        guard let localizedStringDictionary = localizableDictionary.value(forKey: string) as? NSDictionary else {
            return ""
        }
        
        guard let localizedString = localizedStringDictionary.value(forKey: "value") as? String else {
            assertionFailure("Missing translation for: \(string)")
            return ""
        }
        
        return localizedString
    }
}

extension String {
    var localized: String {
        return Localizator.sharedInstance.localize(string: self)
    }
}
