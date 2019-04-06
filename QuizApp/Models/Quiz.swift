//
//  Quiz.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 06/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation
struct Quiz : Codable {
	let quizzes : [Quizzes]?

	enum CodingKeys: String, CodingKey {

		case quizzes = "quizzes"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		quizzes = try values.decodeIfPresent([Quizzes].self, forKey: .quizzes)
	}

}
