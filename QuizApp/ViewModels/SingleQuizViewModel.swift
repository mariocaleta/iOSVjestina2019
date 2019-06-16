//
//  SingleQuizViewModel.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 14/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation

class SingleQuizViewModel {
    var quiz: Quiz? = nil
    
    init(quiz: Quiz) {
        self.quiz = quiz
    }
    
    var title: String{
        return quiz?.title ?? ""
    }
    
    var imageUrl: URL? {
        if let urlString = quiz?.imageUrl {
            return URL(string: urlString)
        }
        return nil
    }
    
    var isQuizOpened: Bool {
        return quiz!.opened
    }
    
    func markQuizOpened() {
        quiz!.opened = true
    }
    
    func markQuizClosed() {
        quiz!.opened = false
    }
}
