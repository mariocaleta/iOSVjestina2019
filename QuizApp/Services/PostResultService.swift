//
//  PostResult.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 19/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation

class PostResultService {
    func postResult(quizId: Int, time: Double, numberOfCorrectAnswers: Int, completion: @escaping ((Int?) -> Void)){
        let urlString = "https://iosquiz.herokuapp.com/api/result"
        let url = URL(string: urlString)
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.string(forKey: "accessToken")
        let userId = Int(userDefaults.string(forKey: "id")!)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(accessToken!)", forHTTPHeaderField: "Authorization")
        
        
        let postString = [
            "quiz_id" : quizId,
            "user_id" : userId!,
            "time" : time,
            "no_of_correct" : numberOfCorrectAnswers
            ] as [String:Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                if let httpResponse = response as? HTTPURLResponse{
                    completion(httpResponse.statusCode)
                } else {
                    print(error.debugDescription)
                }
            }
        }
        dataTask.resume()
    }
}
