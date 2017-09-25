//
//  ModelController.swift
//  2048
//
//  Created by Artem Bobrov on 23.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation



class ModelController {

	enum Key {

		case highScore(for: Int)

		var key: String {
			switch self {
			case .highScore(let dimention):
				return "HighScore \(dimention)"
			}
		}
	}

	static let shared = ModelController()
	
	func save(highScore: Int, for dimention: Int) {
		UserDefaults.standard.set(highScore, forKey: Key.highScore(for: dimention).key)
	}

	func loadHighScore(for dimention: Int) -> Int {
		return UserDefaults.standard.integer(forKey: Key.highScore(for: dimention).key)
	}
	
}
