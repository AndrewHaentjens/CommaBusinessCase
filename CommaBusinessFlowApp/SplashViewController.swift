//
//  SplashViewController.swift
//  CommaBusinessCaseApp
//
//  Created by Andrew Haentjens on 29/08/17.
//  Copyright © 2017 Comma. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DataController.seedBusinessCases()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.performSegue(withIdentifier: "launch", sender: self)
        }
    }
}
