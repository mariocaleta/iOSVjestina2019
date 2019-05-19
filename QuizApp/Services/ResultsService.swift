//
//  ResultsService.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 19/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation

class ResultsService {
    
    func fetchResults(quizId: Int, completion: @escaping (([Results]) -> Void)){
        
        let urlString = "https://iosquiz.herokuapp.com/api/score"
        let url = URL(string: urlString)
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.string(forKey: "accessToken")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(accessToken!)", forHTTPHeaderField: "Authorization")
        
        
        let postString = [
            "quiz_id" : quizId
            ] as [String:Int]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([Results].self, from: data!)
                print(responseModel)
                completion(responseModel)
            }catch{
                print(error)
            }
        }
        dataTask.resume()
    }
}
