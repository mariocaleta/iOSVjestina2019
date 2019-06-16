//
//  Quiz+CoreDataClass.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 16/06/2019.
//  Copyright © 2019 FER. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Quiz)
public class Quiz: NSManagedObject {

    class func firstOrCreate(withId id: Int) -> Quiz? {
        let context = DataController.shared.persistentContainer.viewContext
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        request.returnsObjectsAsFaults = false
        do {
            let quizes = try context.fetch(request)
            if let quiz = quizes.first {
                return quiz
            } else {
                let newQuiz = Quiz(context: context)
                return newQuiz
            }
        } catch {
            return nil
        }
    }
    
    class func createFrom(json: [String: Any]) -> Quiz? {
        if
            let category = json["category"] as? String,
            let description = json["description"] as? String?,
            let id = json["id"] as? Int,
            let image = json["image"] as? String,
            let level = json["level"] as? Int,
            let title = json["title"] as? String,
            let questions = json["questions"] as? [[String: Any]] {
            
            if let quiz = firstOrCreate(withId: id) {
                quiz.category = category
                quiz.desc = description
                quiz.id = Int64(id)
                quiz.imageUrl = image
                quiz.level = Int64(level)
                quiz.title = title
                quiz.opened = false
                
                for questionJson in questions {
                    guard let question = Question.createFrom(json: questionJson) else {
                        return nil
                    }
                    quiz.addToQuestions(question)
                }
                
                do {
                    let context = DataController.shared.persistentContainer.viewContext
                    try context.save()
                    return quiz
                } catch {
                    print("Didnt save")
                }
            }
        }
        return nil
    }
}
