//
//  ViewControllerExtensions.swift
//  CommaBusinessFlowApp
//
//  Created by Andrew Haentjens on 29/08/17.
//  Copyright © 2017 Comma. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
