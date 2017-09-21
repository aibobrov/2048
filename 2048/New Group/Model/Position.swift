//
//  Position.swift
//  2048
//
//  Created by Artem Bobrov on 20.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit

struct Position: Equatable {
	static func ==(lhs: Position, rhs: Position) -> Bool {
		return lhs.x == rhs.x && lhs.y == rhs.y
	}
	
	var x, y: Int
	init(_ x: Int, _ y: Int) {
		(self.x, self.y) = (x, y)
	}
}
