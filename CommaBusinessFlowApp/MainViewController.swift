//
//  MainViewController.swift
//  CommaBusinessCaseApp
//
//  Created by Andrew Haentjens on 27/08/17.
//  Copyright © 2017 Comma. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var surveyTableView: UITableView? {
        didSet {
            guard let surveyTableView = surveyTableView else {
                return
            }
            
            surveyTableView.estimatedRowHeight = 200.0
            surveyTableView.rowHeight = UITableViewAutomaticDimension
            surveyTableView.allowsSelection = false
            surveyTableView.tableFooterView = UIView(frame: .zero)

            let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: surveyTableView.frame.width, height: 144.0))
            let introLabel = UILabel(frame: CGRect(x: 24.0, y: 24.0, width: headerView.frame.width - 48.0, height: headerView.frame.height - 48.0))
            
            introLabel.font = UIFont.systemFont(ofSize: 14.0)
            introLabel.textAlignment = .center
            introLabel.numberOfLines = 5
            introLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc in tincidunt mauris. Duis sodales leo vitae eleifend vulputate. Vivamus risus nulla, accumsan at massa vitae, pellentesque fringilla lectus."
            
            headerView.addSubview(introLabel)
            
            surveyTableView.tableHeaderView = headerView
        }
    }

    @IBOutlet weak var saveButton: BasicButton! {
        didSet {
            saveButton.setTitle("Save".localized, for: .normal)
        }
    }

    var surveyViewModel: SurveyTableViewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Business Case Canvas"
        surveyViewModel = SurveyTableViewViewModel(navigationController: navigationController as? CommaNavigationController)
        
        createPrintIcon()
        
        guard let surveyTableView = surveyTableView else {
            return
        }
        
        surveyTableView.dataSource = surveyViewModel
        surveyTableView.delegate = surveyViewModel
        
        surveyViewModel?.reloadSections = { [weak self] (section: Int) in
            self?.surveyTableView?.beginUpdates()
            self?.surveyTableView?.reloadSections([section], with: .fade)
            self?.surveyTableView?.endUpdates()
        }
    }
    
    private func createPrintIcon() {
        let printButton = UIButton(type: .custom)
        
        printButton.setImage(#imageLiteral(resourceName: "print"), for: .normal)
        printButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        printButton.addTarget(self, action: #selector(createPDF), for: .touchUpInside)
        
        let printBarButton = UIBarButtonItem(customView: printButton)
        navigationItem.rightBarButtonItem = printBarButton
    }
    
    @objc private func createPDF() {
        print("Printin..")
    }

    @IBAction func saveButtonPressed(_ sender: BasicButton) {
        let alert = UIAlertController(title: nil, message: "Saved".localized, preferredStyle: .alert)
        
        DataModel.shared.saveContext()
        
        present(alert, animated: true) { 
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: { 
                alert.dismiss(animated: true, completion: nil)
            })
        }
    }
}
