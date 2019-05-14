//
//  QuizesViewModel.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 14/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation

struct QuizesCellModel{
    
    let title: String
    let description: String
    let level: Int
    let category: String
    let imageURL: URL?
    
    init(quiz: Quizzes) {
        self.title = quiz.title ?? ""
        self.description = quiz.description ?? ""
        self.level = quiz.level ?? 1
        self.category = quiz.category ?? ""
        self.imageURL = URL(string: quiz.image ?? "")
    }
}

class QuizesViewModel {
    
    var quizes: Quiz?
    
    func fetchQuizes(completion: @escaping (() -> Void))  {
        QuizService().fetchQuiz { [weak self] (quizes) in
            self?.quizes = quizes
            completion()
        }
    }
    
    func viewModel(atIndex index: Int) -> SingleQuizViewModel? {
        if let quizes = quizes {
            if index >= 0 && index < quizes.quizzes!.count {
                return SingleQuizViewModel(quiz: quizes.quizzes![index])
            }
        }
        return nil
    }
    
    func quiz(atIndex index: Int) -> QuizesCellModel? {
        guard let quizes = quizes else {
            return nil
        }
        
        let quizCellModel = QuizesCellModel(quiz: quizes.quizzes![index])
        return quizCellModel
    }
    
    func numberOfQuizes() -> Int {
        return quizes?.quizzes!.count ?? 0
    }
}
