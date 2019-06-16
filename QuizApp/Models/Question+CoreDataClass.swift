//
//  Question+CoreDataClass.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 16/06/2019.
//  Copyright © 2019 FER. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Question)
public class Question: NSManagedObject {

    class func firstOrCreate(withId id: Int) -> Question? {
        let context = DataController.shared.persistentContainer.viewContext
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        request.returnsObjectsAsFaults = false
        
        do {
            let questions = try context.fetch(request)
            if let question = questions.first {
                return question
            } else {
                let newQuestion = Question(context: context)
                return newQuestion
            }
        } catch {
            return nil
        }
    }
    
    class func createFrom(json: [String: Any]) -> Question? {
        if
            let answers = json["answers"] as? [String],
            let correctAnswer = json["correct_answer"] as? Int,
            let id = json["id"] as? Int,
            let questionString = json["question"] as? String {
            
            if let question = firstOrCreate(withId: id) {
                question.answers = answers
                question.correctAnswer = Int64(correctAnswer)
                question.id = Int64(id)
                question.question = questionString
                do {
                    let context = DataController.shared.persistentContainer.viewContext
                    try context.save()
                    return question
                } catch {
                    print("Didn't save")
                }
            }
        }
        return nil
    }
}
