//
//  HighScore.swift
//  2048
//
//  Created by Artem Bobrov on 22.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit

class HighScore: Score {
	enum Key: String {
		case highScore = "HighScore"
	}
	override var value: Int {
		willSet {
			if newValue > value {
				UserDefaults.standard.set(newValue, forKey: Key.highScore.rawValue)
			}
		}
		didSet {
			super.value = value
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		value = UserDefaults.standard.integer(forKey: Key.highScore.rawValue)
		self.label.text = "High Score"
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}
}
