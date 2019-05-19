//
//  ResponseCode.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 19/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation

enum ResponseCode {
    case success
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    
    var code: Int{
        switch self {
        case .success:
            return 200
        case .badRequest:
            return 400
        case .unauthorized:
            return 401
        case .forbidden:
            return 403
        case .notFound:
            return 404
        }
    }
}
