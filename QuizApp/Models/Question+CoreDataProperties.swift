//
//  Question+CoreDataProperties.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 16/06/2019.
//  Copyright © 2019 FER. All rights reserved.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var answers: [String]
    @NSManaged public var correctAnswer: Int64
    @NSManaged public var id: Int64
    @NSManaged public var question: String

}
