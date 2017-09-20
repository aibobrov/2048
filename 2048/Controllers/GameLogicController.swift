//
//  GameController.swift
//  2048
//
//  Created by Artem Bobrov on 04.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit

class GameLogicController {
	let board: Board
	var score: Int = 0 {
		didSet {
			delegate?.scoreDidChanged(to: score)
		}
	}
	var delegate: GameControllerDelegate?

	var updating = false

	var isGameEnded: Bool {
		return isUserWon || isUserLost
	}
	var isUserLost: Bool = false {
		didSet {
			if !oldValue && isUserLost {
				delegate?.userDidLost()
			}
		}
	}
	var isUserWon: Bool = false {
		didSet{
			if !oldValue && isUserWon {
				delegate?.userDidWon()
			}
		}
	}

	init(board: Board) {
		self.board = board
	}


	func reset() {
		score = 0		
		board.tiles.forEach({ $0?.removeFromSuperview() })
		board.tiles = board.tiles.map({ _ in nil })
	}

	func restart() {
		reset()
		for _ in 0...1 {
			insetNewTile()
		}
		//		let newValue = 2
		//		setTest(value: newValue, on: (0, 0))
		//		setTest(value: newValue, on: (0, 2))
	}

	func insetNewTile() {
		let newValue = newTileValue
		set(newValue: newValue)
		score += newValue
	}
	private func setTest(value: Int, on position: (Int, Int)) {
		guard  board.emptyTiles.count > 0 else {
			isUserLost = true
			return
		}

		let idx = position.0 * board.dimention + position.1
		let rect = board.tilesRects[idx]
		setup(newTile: &board.tiles[idx], position: Position(idx / board.dimention, idx & board.dimention), frame: rect, value: value)
	}

	func set(newValue value: Int) {
		guard  board.emptyTiles.count > 0 else {
			isUserLost = true
			return
		}

		var idx = Int(arc4random()) % board.tiles.count
		while board.tiles[idx] != nil {
			idx = Int(arc4random()) % board.tiles.count
		}

		let rect = board.tilesRects[idx]
		setup(newTile: &board.tiles[idx], position: Position(idx / board.dimention, idx % board.dimention), frame: rect, value: value)
	}

	func setup(newTile tile: inout Tile?, position: Position,frame: CGRect, value: Int) {
		tile = Tile(position: position, radius: Board.radius, size: frame.size, origin: frame.origin)
		tile?.value = value
		board.addSubview(tile!)
		board.bringSubview(toFront: tile!)

		if let tile = tile { // appearance animation
			let scale: CGFloat = 0.25
			tile.transform = CGAffineTransform(scaleX: scale, y: scale)
			tile.alpha = 0
			UIView.animate(withDuration: 0.2, animations: {
				tile.transform = CGAffineTransform(scaleX: 1, y: 1)
				tile.alpha = 1.0
			})
		}
	}

	private var newTileValue: Int {
		let rnd = arc4random() % 10
		return rnd < 2 ? 4 : 2
	}

}

extension GameLogicController {
	func move(to direction: MoveDirection) {
		if updating {return}
		updating = true
		shift(to: direction)
		insetNewTile()
		updating = false
	}

	func shift(to direction: MoveDirection) {
	}

	private func printTiles() {
		print("===<<<<<<<<<<===")
		for x in 0..<board.dimention {
			let rowIndexes = x * board.dimention..<(x + 1) * board.dimention
			let row = board.tiles[rowIndexes]
			print(rowIndexes, "\(row)")
		}
	}
}

extension GameLogicController {

	func canOneTileMoveDown(location: (Int, Int)) -> Bool {
		return 0..<board.dimention - 1 ~= location.0 && board[location.0 + 1, location.1] == nil
	}

	func canOneTileMoveUp(location: (Int, Int)) -> Bool {
		return 1..<board.dimention ~= location.0 && board[location.0 - 1, location.1] == nil
	}

	func canOneTileMoveLeft(location: (Int, Int)) -> Bool {
		return 1..<board.dimention ~= location.1 && board[location.0, location.1 - 1] == nil
	}

	func canOneTileMoveRight(location: (Int, Int)) -> Bool {
		return 0..<board.dimention - 1 ~= location.1 && board[location.0, location.1 + 1] == nil
	}

	func tileToLeftHasSameValue(location: (Int, Int), value: Int) -> Bool {
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

	func tileToRightHasSameValue(location: (Int, Int), value: Int) -> Bool {
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

	func tileAboveHasSameValue(location: (Int, Int), value: Int) -> Bool {
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

	func tileBelowHasSameValue(location: (Int, Int), value: Int) -> Bool {
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
}
