//
//  Results.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 19/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation

struct Results : Codable {
    let username : String?
    let score : String?
    
    enum CodingKeys: String, CodingKey {
  
        case username = "username"
        case score = "score"
    }
  
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        score = try values.decodeIfPresent(String.self, forKey: .score)
    }
}
