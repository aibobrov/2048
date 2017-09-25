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
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.label.text = "High Score"
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}
}
