//
//  SurveyHeaderView.swift
//  CommaBusinessCaseApp
//
//  Created by Andrew Haentjens on 27/08/17.
//  Copyright © 2017 Comma. All rights reserved.
//

import UIKit

protocol SurveyHeaderViewDelegate: class {
    func toggleSection(header: SurveyHeaderView, section: Int)
}

class SurveyHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var arrowImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel? {
        didSet {
            titleLabel?.textColor = .black
        }
    }
    
    var item: SurveyTableViewViewModelItem? {
        didSet {
            guard let item = item else {
                return
            }
            
            titleLabel?.text = item.sectionTitle
            setCollapsed(collapsed: item.isCollapsed)
        }
    }
    
    weak var delegate: SurveyHeaderViewDelegate?
    
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }

    func setCollapsed(collapsed: Bool) {
        
        arrowImageView?.rotate(collapsed ? -(.pi / 2) : 0.0)
        
        if collapsed {
            UIView.animate(withDuration: 0.2) {
                self.titleLabel?.textColor = .black
                self.arrowImageView?.image = #imageLiteral(resourceName: "ArrowBlack")
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.titleLabel?.textColor = UIColor.Green.darkGreen
                self.arrowImageView?.image = #imageLiteral(resourceName: "ArrowGreen")
            }
        }
    }
}

extension UIImageView {
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.layer.add(animation, forKey: nil)
    }
}
