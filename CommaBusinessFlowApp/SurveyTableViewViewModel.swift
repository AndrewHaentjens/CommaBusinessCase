//
//  SurveyTableViewViewModel.swift
//  CommaBusinessCaseApp
//
//  Created by Andrew Haentjens on 27/08/17.
//  Copyright © 2017 Comma. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// Possible types of cell
enum SurveyTableViewViewModelItemType {
    case openQuestion
}

protocol SurveyTableViewViewModelItem {
    var type: SurveyTableViewViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
    var tips: String { get }
    var answer: String { get set }
    
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
}

extension SurveyTableViewViewModelItem {
    var rowCount: Int {
        return 1
    }
    
    var isCollapsible: Bool {
        return true
    }
}

class SurveyTableViewViewModelOpenQuestionItem: SurveyTableViewViewModelItem {

    var sectionTitle: String {
        return question
    }

    var type: SurveyTableViewViewModelItemType {
        return .openQuestion
    }
    
    var tips: String {
        return answerTips
    }

    var answer: String {
        didSet {
            
        }
    }
    
    var isCollapsed: Bool = true
    var question: String
    var answerTips: String
    
    init(question: String, answerTips: String, answers: String?) {

        self.question = question
        self.answerTips = answerTips
        self.answer = answers == nil ? "" : answers!
    }
}

class SurveyTableViewViewModel: NSObject {
    let headerNib = UINib(nibName: "SurveyHeaderView", bundle: nil)
    
    var navigationController: CommaNavigationController?
    var items = [SurveyTableViewViewModelItem]()
    var reloadSections: ((_ section: Int) -> ())?
    
    init(navigationController: CommaNavigationController?) {
        super.init()
        self.navigationController = navigationController
        
        guard let entities = DataController.fetchAllBusinessCases() else {
            return
        }
 
        for entity in entities {
            guard let question = entity.question, let tips = entity.tips else {
                continue
            }
            
            let item = SurveyTableViewViewModelOpenQuestionItem(question: question, answerTips: tips, answers: entity.answer)
            items.append(item)
        }
    }
}

extension SurveyTableViewViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "SurveyHeaderView")
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SurveyHeaderView") as? SurveyHeaderView else {
            return UIView()
        }
        
        headerView.item = items[section]
        headerView.section = section
        headerView.delegate = self
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = items[section]
        
        if item.isCollapsible && item.isCollapsed {
            return 0
        }
        
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        
        switch item.type {
        case .openQuestion:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "openQuestionsCell") as? OpenQuestionTableViewCell else {
                return UITableViewCell()
            }
            
            cell.item = nil
            cell.delegate = self
            cell.section = indexPath.section
            cell.navigationController = navigationController
            cell.item = item
            

            return cell
        }        
    }
}

extension SurveyTableViewViewModel: SurveyHeaderViewDelegate {
    func toggleSection(header: SurveyHeaderView, section: Int) {
        var item = items[section]
        
        if item.isCollapsible {
            let collapsed = !item.isCollapsed
            item.isCollapsed = collapsed
            
            header.setCollapsed(collapsed: collapsed)
            
            reloadSections?(section)
        }
    }
}

// TODO: fix this
extension SurveyTableViewViewModel: OpenQuestionTableViewCellDelegate {
    func saveFilledInTextViewtoDatabase(question: String, answer: String) {
        for (index, item) in items.enumerated() where item.sectionTitle == question {
            items[index].answer = answer
        }
        _ = DataController.updateBusinessCase(question, withAnswer: answer)
    }
}
