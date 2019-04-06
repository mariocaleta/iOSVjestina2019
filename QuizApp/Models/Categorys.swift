//
//  Categorys.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 06/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation
import UIKit

enum CategoryType {
    case sports
    case science
    
    var color : UIColor{
    switch self {
    
    case .sports:
        return UIColor.red
    
    case .science:
        return UIColor.blue
        }
    }
}
