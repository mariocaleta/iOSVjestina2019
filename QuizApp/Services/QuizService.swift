//
//  QuizService.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 06/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation

class QuizService {
    
    func fetchQuiz(completion: @escaping ((Quiz?) -> Void)){
        
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        
        if let url = URL(string: urlString) {
           
            let request = URLRequest(url: url)
            
            print("creating data task")
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
               
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(Quiz.self, from: data!)
                    print(responseModel)
                    completion(responseModel)
                } catch {
                    print(error)
                    completion(nil)
                }
            }
        dataTask.resume()
    }
        else {
            completion(nil)
        }
}
    
}
