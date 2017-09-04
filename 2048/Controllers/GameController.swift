//
//  GameController.swift
//  2048
//
//  Created by Artem Bobrov on 04.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation

class GameController {
	let board: Board
	var score: Int = 0 {
		didSet {
			delegate?.scoreDidChanged!(to: score)
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
		for tile in board.tiles {
			tile.value = nil
		}
	}

	func start() {
		reset()
		set(value: getNewValue(), onTiles: board.emptyTiles())
		set(value: getNewValue(), onTiles: board.emptyTiles())
	}

	func set(value: Int, onTiles tiles: [Tile]) {
		guard  tiles.count > 0 else {
			isGameEnded = true
			return
		}
		tiles[Int(arc4random()) % tiles.count].value = value
	}

	 func getNewValue() -> Int {
		let rnd = arc4random() % 10
		return rnd < 2 ? 4 : 2
	}
}
extension GameController {
	func tileToLeftHasSameValue(location: (Int, Int), value: Int) -> Bool {
		let (x, y) = location
		guard x != 0 else {
			return false
		}
		if let first = board[x, y].value,
			let second = board[x - 1, y].value {
			return first == second
		}
		return false
	}

	func tileToRightHasSameValue(location: (Int, Int), value: Int) -> Bool {
		let (x, y) = location
		guard x != board.dimention - 1 else {
			return false
		}
		if let first = board[x, y].value,
			let second = board[x + 1, y].value {
			return first == second
		}
		return false
	}

	func tileAboveHasSameValue(location: (Int, Int), value: Int) -> Bool {
		let (x, y) = location
		guard y != 0 else {
			return false
		}
		if let first = board[x, y].value,
			let second = board[x, y - 1].value {
			return first == second
		}
		return false
	}

	func tileBelowHasSameValue(location: (Int, Int), value: Int) -> Bool {
		let (x, y) = location
		guard y != board.dimention - 1 else {
			return false
		}
		if let first = board[x, y].value,
			let second = board[x, y + 1].value {
			return first == second
		}
		return false
	}
}

extension GameController: GameControllerMoveProtocol {

	func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {

	}
	func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int) {

	}
}










