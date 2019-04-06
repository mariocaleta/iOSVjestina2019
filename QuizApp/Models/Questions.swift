//
//  Questions.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 06/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import Foundation
struct Questions : Codable {
	let id : Int?
	let question : String?
	let answers : [String]?
	let correct_answer : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case question = "question"
		case answers = "answers"
		case correct_answer = "correct_answer"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		question = try values.decodeIfPresent(String.self, forKey: .question)
		answers = try values.decodeIfPresent([String].self, forKey: .answers)
		correct_answer = try values.decodeIfPresent(Int.self, forKey: .correct_answer)
	}

}
