//
//  ResultsService.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 19/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation

class ResultsService {
    
    func fetchResults(quizId: Int, completion: @escaping (([Results]?) -> Void)){
        
        let urlString = "https://iosquiz.herokuapp.com/api/score?quiz_id=\(quizId)"
        let url = URL(string: urlString)
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.string(forKey: "accessToken")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(accessToken!)", forHTTPHeaderField: "Authorization")
        
        
      //  let postString = [
      //      "quiz_id" : quizId
      //      ] as [String:Int]
      //
      //  do {
      //      request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
      //      print(request.httpBody!)
      //  } catch let error {
      //      print(error.localizedDescription)
      //  }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data{
            do{
                // .allowFragments ili []
                //let jsonString = String(data: data, encoding: .utf8)
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                var resultssss: [Results] = []
                if let results = json as? [[String:String]]{
                    for result in results{
                        let username = result["username"]
                        let score = result["score"]
                        let result = Results(username: username!, score: score!)
                        resultssss.append(result)
                    }
                }
                completion(Array(resultssss.prefix(20)))
       //         if let resultsList = json as? [[String: Any]]{
       //             let results = resultsList.map({ json -> Results? in
       //                 print(json)
       //                 if
       //                     let username = json["username"] as? String,
       //                     let score = json["score"] as? String{
       //                     let result = Results(username: username, score: score)
       //                     return result
       //                 }else{
       //                     return nil
       //                 }
       //             }).filter{ $0 != nil}.map{ $0!}
       //             completion(results)
       //         } else{
       //             completion(nil)
       //         }
           //      let jsonDecoder = JSONDecoder()
           //      let responseModel = try jsonDecoder.decode([Results].self, from: data)
           //      print(responseModel)
           //      completion(responseModel)
            }catch{
                print(error)
            }
        }
        }
        dataTask.resume()
    }
}
