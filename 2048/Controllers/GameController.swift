//
//  GameController.swift
//  2048
//
//  Created by Artem Bobrov on 04.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit

class GameController {
	let board: Board
	var score: Int = 0 {
		didSet {
			delegate?.scoreDidChanged(to: score)
		}
	}
	var delegate: GameControllerDelegate?

	var isGameEnded: Bool {
		didSet {
			if !oldValue && isGameEnded {
				delegate?.userDidLost()
			}
			if !isGameEnded {
				start()
			}
		}
	}

	init(board: Board) {
		self.board = board
		isGameEnded = false
	}


	func reset() {
		for tile in board.emptyTiles {
			if let tile = tile.0 {
				tile.value = nil
			}
		}
	}
	// FIXME: doens't restarts
	func start() {
		reset()
		for _ in 0...1 {
			let newValue = getNewValue()
			set(value: newValue, onTiles: board.emptyTiles)
			score += newValue
		}
	}

	func set(value: Int, onTiles tiles: [(Tile?, CGRect)]) {
		guard  tiles.count > 0 else {
			isGameEnded = true
			return
		}
		let rndNumber = Int(arc4random()) % tiles.count
		var (tile, rect) = tiles[rndNumber]
		tile = Tile(radius: Board.radius, size: rect.size, origin: rect.origin)
		tile?.value = value
		board.addSubview(tile!)
		board.bringSubview(toFront: tile!)
	}

	func getNewValue() -> Int {
		let rnd = arc4random() % 10
		return rnd < 2 ? 4 : 2
	}

	func performMove() {

	}
}

extension GameController {
	func tileToLeftHasSameValue(location: (Int, Int), value: Int) -> Bool {
		let (x, y) = location
		guard x != 0 else {
			return false
		}
		if let firstTile = board[x, y],
			let secondTile = board[x - 1, y],
			let first = firstTile.value,
			let second = secondTile.value {
			return first == second
		}
		return false
	}

	func tileToRightHasSameValue(location: (Int, Int), value: Int) -> Bool {
		let (x, y) = location
		guard x != board.dimention - 1 else {
			return false
		}
		if let firstTile = board[x, y],
			let secondTile = board[x + 1, y],
			let first = firstTile.value,
			let second = secondTile.value {
			return first == second
		}
		return false
	}

	func tileAboveHasSameValue(location: (Int, Int), value: Int) -> Bool {
		let (x, y) = location
		guard y != 0 else {
			return false
		}
		if let firstTile = board[x, y],
			let secondTile = board[x, y - 1],
			let first = firstTile.value,
			let second = secondTile.value {
			return first == second
		}
		return false
	}

	func tileBelowHasSameValue(location: (Int, Int), value: Int) -> Bool {
		let (x, y) = location
		guard y != board.dimention - 1 else {
			return false
		}
		if let firstTile = board[x, y],
			let secondTile = board[x, y + 1],
			let first = firstTile.value,
			let second = secondTile.value {
			return first == second
		}
		return false
	}
}
