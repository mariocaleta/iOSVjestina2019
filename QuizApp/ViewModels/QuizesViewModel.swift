//
//  QuizesViewModel.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 14/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation
import Reachability

struct QuizesCellModel{
    
    let title: String
    let description: String
    let level: Int
    let category: String
    let imageURL: URL?
    
    init(quiz: Quiz) {
        self.title = quiz.title
        self.description = quiz.desc ?? ""
        self.level = Int(quiz.level)
        self.category = quiz.category
        self.imageURL = URL(string: quiz.imageUrl ?? "")
    }
}

class QuizesViewModel {
    
    var quizes: [Quiz]?
    var sortedQuizes: [[Quiz]] = []
    var helpArray: [Quiz] = []
    var categorys: [String] = []
    var reachability = Reachability()!
    private var isFetched: Bool = false
    
    func fetchQuizes(completion: @escaping (() -> Void))  {
        if(!self.isFetched) {
            self.quizes = DataController.shared.fetchQuiz()
            self.setArray(quiz: (self.quizes)!)
            if (reachability.connection == .wifi || reachability.connection == .cellular) {
                QuizService().fetchQuiz { [weak self] (quizes) in
                    self?.quizes = DataController.shared.fetchQuiz()
                    self?.setArray(quiz: (self?.quizes)!)
                    self?.isFetched = true
                    completion()
                }
            }
        } else {
            self.quizes = DataController.shared.fetchQuiz()
            self.setArray(quiz: (self.quizes)!)
        }
    }
    
    func searchQuizes(keyword: String) {
        self.quizes = DataController.shared.searchQuizes(keyword: keyword)
        self.setArray(quiz: quizes!)
    }
    
    func setArray(quiz: [Quiz]){
        sortedQuizes.removeAll()
        categorys.removeAll()
        for i in 0..<quiz.count{
            categorys.append(quizes![i].category)
        }
        let uniqueCategorys = Array(Set(categorys))
        categorys = uniqueCategorys
        
        for i in 0..<categorys.count{
            for j in 0..<quiz.count{
                if (categorys[i] == quiz[j].category){
                    helpArray.append(quiz[j])
                }
            }
            sortedQuizes.append(helpArray)
            helpArray.removeAll()
        }
    }
    
    func singleQuizViewModel(atIndex quiz: Quiz) -> SingleQuizViewModel? {
        return SingleQuizViewModel(quiz: quiz)
    }
    
    func quiz(atIndex index: Int) -> QuizesCellModel? {
        guard let quizes = quizes else {
            return nil
        }
        
        let quizCellModel = QuizesCellModel(quiz: quizes[index])
        return quizCellModel
    }
    
    func cellForRow(quiz: Quiz) -> QuizesCellModel? {
        let quizCellModel = QuizesCellModel(quiz: quiz)
        return quizCellModel
    }
    
    
    func numberOfQuizes() -> Int {
        return quizes?.count ?? 0
    }
    
    func quizData() -> [Quiz] {
        return quizes!
    }
}
