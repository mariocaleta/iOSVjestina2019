//
//  Quizzes.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 06/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

//import Foundation
//struct Quizzes : Codable {
//	let id : Int?
//	let title : String?
//	let description : String?
//	let category : String?
//	let level : Int?
//	let image : String?
//	let questions : [Questions]?
//
//	enum CodingKeys: String, CodingKey {
//
//		case id = "id"
//		case title = "title"
//		case description = "description"
//		case category = "category"
//		case level = "level"
//		case image = "image"
//		case questions = "questions"
//	}
//
//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		id = try values.decodeIfPresent(Int.self, forKey: .id)
//		title = try values.decodeIfPresent(String.self, forKey: .title)
//		description = try values.decodeIfPresent(String.self, forKey: .description)
//		category = try values.decodeIfPresent(String.self, forKey: .category)
//		level = try values.decodeIfPresent(Int.self, forKey: .level)
//		image = try values.decodeIfPresent(String.self, forKey: .image)
//		questions = try values.decodeIfPresent([Questions].self, forKey: .questions)
//	}
//
//}
//
