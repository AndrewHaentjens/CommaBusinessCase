//
//  BaseViewController.swift
//  CommaBusinessCaseApp
//
//  Created by Andrew Haentjens on 28/08/17.
//  Copyright © 2017 Comma. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        hideKeyboard()
    }
}
