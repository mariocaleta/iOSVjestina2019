//
//  SingleQuizViewModel.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 14/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation

class SingleQuizViewModel {
    var quiz: Quizzes? = nil
    
    init(quiz: Quizzes) {
        self.quiz = quiz
    }
    
    var title: String{
        return quiz?.title ?? ""
    }
    
    var imageUrl: URL? {
        if let urlString = quiz?.image {
            return URL(string: urlString)
        }
        return nil
    }
}
