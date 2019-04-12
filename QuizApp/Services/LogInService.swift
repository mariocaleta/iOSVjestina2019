//
//  LogInService.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 11/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation

class LogInService {
    
    func fetchAccessToken(username : String, password : String, completion: @escaping ((String?) -> Void)){
        
        let urlString = "https://iosquiz.herokuapp.com/api/session"
        
        let url = URL(string: urlString)
            
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = [
                            "username" : username,
                            "password" : password
                         ] as [String:String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
            
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json {
                    let accessToken = parseJSON["token"] as? String
                    if (accessToken == nil)
                    {
                        completion(nil)
                    }
                   // print("acess token je: \(String(describing: accessToken!))")
                    completion(accessToken)
                }
            } catch {
                print(error)
                completion(nil)
            }
            
            }
            dataTask.resume()
    }
}
