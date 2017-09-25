//
//  Tile.swift
//  2048
//
//  Created by Artem Bobrov on 21.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit

class Tile {
	let position: Position
	var value: Int?

	var upTile: Tile?
	var rightTile: Tile?
	var bottomTile: Tile?
	var leftTile: Tile?

	init(position: Position, value: Int? = nil) {
		self.position = position
		self.value = value
	}
}
