//
//  BasicButton.swift
//  CommaBusinessCaseApp
//
//  Created by Andrew Haentjens on 28/08/17.
//  Copyright © 2017 Comma. All rights reserved.
//

import UIKit

class BasicButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.Green.darkGreen
        setTitleColor(.white, for: .normal)
    }

}
