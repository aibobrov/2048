//
//  GameControllerProtocols.swift
//  2048
//
//  Created by Artem Bobrov on 04.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation

protocol GameLogicManagerDelegate {
	func userDidLost()
	func scoreDidChanged(to score: Int)
	func userDidWon()
	func nothingChangedShift(to direction: MoveDirection)
	func didCreatedTile(_ tile: Tile?)
	func didMoveTile(from source: Tile, to destination: Tile, completion: @escaping ()->Void)
	func didMoveTile(from source: Tile, to destination: Position, completion: @escaping ()->Void)
}

protocol GameSourceDelegate {
	func boardValuesChanged(to tiles: [Tile])
}

enum MoveDirection {
	case up
	case down
	case left
	case right
}
