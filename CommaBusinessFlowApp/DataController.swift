//
//  DataController.swift
//  CommaBusinessFlowApp
//
//  Created by Andrew Haentjens on 29/08/17.
//  Copyright © 2017 Comma. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    static func seedBusinessCases() {
        guard fetchAllBusinessCases()?.count == 0 else {
            return
        }
        
        let context = DataModel.shared.context
        
        let questions = [
            "Problem".localized,
            "Solution".localized,
            "Resources".localized,
            "Benefits".localized,
            "Scope".localized,
            "Risks".localized,
            "Stakeholders".localized,
            "Cost Structure".localized,
            "Metrics".localized
        ]
        
        let tipsForQ1 = [
            "What is the problem? \n Who has the problem? \n Why is it important?",
            "Description of the proposed solution? \n Relate the solution to the problem.",
            "What do we need? \n Who are the key players? \n Who is needed in the company? \n Who is required externally?",
            "Why are we doing this? \n What do we intend to achieve?",
            "What does the solution involve? \n What is nog covered by the solution? \n How much time, resource, technology do we have?",
            "What other projects are we depending on?\n What could go wrong? \n What is the impact of the risk? \n Suggested contingency? \n Mitigation actions?",
            "Who are the stakeholders \n Communication approach? \n Key interests and issues? \n Current status - Advocate, Supporter, Neutral, Critic, Blocker? \n Desired support \n Desired project role? \n Desired actions? \n Messages needed?",
            "Internal costs? \n External costs?",
            "How can we measure success? \n What metric can be used to measure the benefits \n Time? \n Quality? \n Speed?"
        ]
        
        for (index, question) in questions.enumerated() {
            guard let entity = NSEntityDescription.entity(forEntityName: "BusinessCase", in: context) else {
                continue
            }
            
            let businessCase = BusinessCase(entity: entity, insertInto: context)
            businessCase.question = question
            businessCase.tips = tipsForQ1[index]
            
            do {
                try context.save()
            } catch (let error) {
                print("Could not save: \(error.localizedDescription)")
            }
        }        
    }
    
    static func fetchAllBusinessCases() -> [BusinessCase]? {
        let context = DataModel.shared.context
        let businessCaseFetch: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "BusinessCase")
        
        
        do {
            let result = try context.fetch(businessCaseFetch)
            
            guard let cases = result as? [BusinessCase] else {
                return nil
            }
            
            return cases
            
        } catch(let error) {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func updateBusinessCase(_ question: String, withAnswer: String) -> Bool {
        let context = DataModel.shared.context
        let businessCaseFetch: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "BusinessCase")
        let questionPredicate = NSPredicate(format: "question = %@", question)
        
        businessCaseFetch.predicate = questionPredicate
        
        do {
            let results = try context.fetch(businessCaseFetch)
            
            if let businessCase = results.first as? BusinessCase {
                businessCase.answer = withAnswer
                return true
            }
            
        } catch(let error) {
            print(error.localizedDescription)
            return false
        }
        
        return false
    }
}
