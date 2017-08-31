//
//  CommaNavigationController.swift
//  CommaBusinessCaseApp
//
//  Created by Andrew Haentjens on 28/08/17.
//  Copyright © 2017 Comma. All rights reserved.
//

import UIKit

class CommaNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.backgroundColor = UIColor.Green.darkGreen
        navigationBar.barTintColor = UIColor.Green.darkGreen
        
        var titleTextAttributes = [String: Any]()
        titleTextAttributes[NSForegroundColorAttributeName] = UIColor.white
        navigationBar.titleTextAttributes = titleTextAttributes
    }
}
