//
//  LogInService.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 11/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation
import UIKit

class LogInService {
    enum LoginResponse {
        case noInternet
        case loginFailed
        case success(token: String)
    }
    
    func fetchAccessToken(username : String, password : String, completion: @escaping ((String?) -> Void)) {
        
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
                if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet
                {
                    print("There is no internet connection!")
                    completion("No internet")
                //    let alertController = UIAlertController(title: "Alert", message: "There is no internet connection!", preferredStyle: .alert)
              //      alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                    
       //             let alertWindow = UIWindow(frame: UIScreen.main.bounds)
       //             alertWindow.rootViewController = UIViewController()
       //             alertWindow.windowLevel = UIWindow.Level.alert + 1;
       //             alertWindow.makeKeyAndVisible()
       //             alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
                }
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json {
                    let accessToken = parseJSON["token"] as? String
                    let id = parseJSON["user_id"] as? Int
                    if (accessToken == nil || id == nil)
                    {
                        completion(nil)
                    }else{
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(accessToken, forKey: "accessToken")
                        userDefaults.set(id, forKey: "id")
                        userDefaults.set(username, forKey: "username")
                    }
                   // print("acess token je: \(String(describing: accessToken!))")
                    completion(accessToken)
                }
            } catch {
                print(error)
                if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet{
                    completion("No internet")
                }
            }
            }
            dataTask.resume()
    }
}
