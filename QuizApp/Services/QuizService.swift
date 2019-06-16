//
//  QuizService.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 06/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation

class QuizService {
    
    func fetchQuiz(completion: @escaping ([Quiz]?) -> Void){
        
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        
        if let url = URL(string: urlString) {
           
            let request = URLRequest(url: url)
            
            print("creating data task")
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
               
                var quizzes: [Quiz] = []
                
                if(data == nil){
                    completion(nil)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    guard let jsonDict = json as? [String: Any], let jsonResults = jsonDict["quizzes"] as? [[String: Any]] else {
                        completion(nil)
                        return
                    }
                    jsonResults.forEach {
                        if let quiz = Quiz.createFrom(json: $0) {
                            quizzes.append(quiz)
                        }
                    }
                    completion(quizzes)
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
