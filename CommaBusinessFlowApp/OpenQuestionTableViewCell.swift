//
//  OpenQuestionTableViewCell.swift
//  CommaBusinessCaseApp
//
//  Created by Andrew Haentjens on 27/08/17.
//  Copyright © 2017 Comma. All rights reserved.
//

import UIKit

protocol OpenQuestionTableViewCellDelegate: class {
    func saveFilledInTextViewtoDatabase(question: String, answer: String)
}

class OpenQuestionTableViewCell: UITableViewCell {
    
    weak var navigationController: UINavigationController?
    weak var delegate: OpenQuestionTableViewCellDelegate?

    @IBOutlet weak var answerTextView: UITextView? {
        didSet {
            answerTextView?.textColor = .lightGray
            answerTextView?.text = placeholder
            answerTextView?.delegate = self
        }
    }

    @IBOutlet weak var infoButton: UIButton! {
        didSet {
            infoButton.isHidden = false
            infoButton.isEnabled = true
            infoButton.tintColor = UIColor.Green.brightGreen
        }
    }
    
    let placeholder = "Start typing here..."

    var item: SurveyTableViewViewModelItem? {
        didSet {
            guard let item = item else {
                return
            }

            if item.answer != "" {
                answerTextView?.textColor = .black
                answerTextView?.text = item.answer
            }
            
            section = item.rowCount
        }
    }

    var section: Int = 0
    
    override func prepareForReuse() {
        item = nil
        section = 0
        answerTextView?.textColor = .lightGray
        answerTextView?.text = placeholder
        answerTextView?.delegate = self
    }
    
    @IBAction func infoButtonPressed(sender: UIButton) {
        let tipsAlert = UIAlertController(title: "InfoTitle".localized, message: item?.tips, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close".localized, style: .cancel, handler: nil)
        
        tipsAlert.addAction(closeAction)
        navigationController?.present(tipsAlert, animated: true, completion: nil)
    }
}

extension OpenQuestionTableViewCell: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        if textView.text == placeholder {
            textView.text = ""
        }
        
        textView.textColor = .black
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.characters.count == 0 {
            answerTextView?.text = placeholder
            textView.textColor = .lightGray
            return true
        }
        
        if textView.text != placeholder, let question = item?.sectionTitle {
            delegate?.saveFilledInTextViewtoDatabase(question: question, answer: textView.text)
        }
        
        return true
    }

}
