//
//  QuizService.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 06/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation
import UIKit

class QuizImageService {
    
    func fetchQuizImage(quizImage : String, completion: @escaping ((UIImage?) -> Void)){
        
        if let url = URL(string: quizImage) {
            
            let request = URLRequest(url: url)
            
            print("creating data task")
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("fetched image")
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                    print("completion called")
                } else {
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
