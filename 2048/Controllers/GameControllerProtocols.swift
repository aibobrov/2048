//
//  GameControllerProtocols.swift
//  2048
//
//  Created by Artem Bobrov on 04.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation

protocol GameControllerDelegate {
	func userDidLost()
	func scoreDidChanged(to score: Int)
	func userDidWon()
}

enum MoveDirections {
	case up
	case down
	case left
	case right
}

protocol GameControllerMoveProtocol {
	func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int)
	func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int)
}
