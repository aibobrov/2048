//
//  ModelController.swift
//  2048
//
//  Created by Artem Bobrov on 23.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation



class ModelController {

	enum Key: String {
		case highScore = "HighScore"
	}

	static let shared = ModelController()
	
	func save(highScore: Int) {
		UserDefaults.standard.set(highScore, forKey: Key.highScore.rawValue)
	}

	func loadHighScore() -> Int {
		return UserDefaults.standard.integer(forKey: Key.highScore.rawValue)
	}
}
