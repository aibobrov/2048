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
		}
	}

	init(board: Board) {
		self.board = board
		isGameEnded = false
	}


	func reset() {
		score = 0
		board.tiles.forEach({ $0?.removeFromSuperview() })
		board.tiles = board.tiles.map({ _ in nil })
	}
	// FIXME: doens't restarts
	func start() {
		reset()
		for _ in 0...1 {
			let newValue = getNewValue()
			set(newValue: newValue, onTiles: &board.tiles)
			score += newValue
		}
	}

	func set(newValue value: Int, onTiles tiles: inout [Tile?]) {
		guard  tiles.count > 0 else {
			isGameEnded = true
			return
		}
		var idx = Int(arc4random()) % tiles.count
		while tiles[idx] != nil {
			idx = Int(arc4random()) % tiles.count
		}
		let rect = board.tilesRects[idx]
		tiles[idx] = Tile(radius: Board.radius, size: rect.size, origin: rect.origin)
		tiles[idx]?.value = value
		board.addSubview(tiles[idx]!)
		board.bringSubview(toFront: tiles[idx]!)
		check(tiles)
	}

	func check(_ tiles: [Tile?]) {
		for (idx, tile) in tiles.enumerated() {
			if let _ = tile {
				print("[\(idx % board.dimention), \(idx / board.dimention)]", "not nil")
			} else {
				print("-[\(idx % board.dimention), \(idx / board.dimention)]", "nil")
			}
		}
		print("---------------------------")
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
