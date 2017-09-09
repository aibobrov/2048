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
			isGameEnded = true
			return
		}

		let idx = position.0 * board.dimention + position.1
		let rect = board.tilesRects[idx]
		setup(newTile: &board.tiles[idx], frame: rect, value: value)
	}

	func set(newValue value: Int) {
		guard  board.emptyTiles.count > 0 else {
			isGameEnded = true
			return
		}

		var idx = Int(arc4random()) % board.tiles.count
		while board.tiles[idx] != nil {
			idx = Int(arc4random()) % board.tiles.count
		}

		let rect = board.tilesRects[idx]
		setup(newTile: &board.tiles[idx], frame: rect, value: value)
	}

	func setup(newTile tile: inout Tile?, frame: CGRect, value: Int) {
		tile = Tile(radius: Board.radius, size: frame.size, origin: frame.origin)
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

	func check(_ objects: [Any?]) {
		for (_, object) in objects.enumerated() {
			if let _ = object {
//				print("[\(idx % board.dimention), \(idx / board.dimention)]", "not nil")
			} else {
//				print("-[\(idx % board.dimention), \(idx / board.dimention)]", "nil")
			}
		}
//		print("---------------------------")
	}

	private var newTileValue: Int {
		let rnd = arc4random() % 10
		return rnd < 2 ? 4 : 2
	}

}

extension GameController {
	func move(to direction: MoveDirection) {
		switch direction {
		case .left:
			left()
		case .right:
			right()
		case .up:
			up()
		case .down:
			down()
		}
		insetNewTile()
	}

	private func left() {
		for _ in 0..<4 {
			for x in 0..<board.dimention { // row
				let rowIndexes = x * board.dimention..<(x + 1) * board.dimention
				var row = board.tiles[rowIndexes]
				for y in rowIndexes.dropFirst() { // column
					guard let tile =  row[y] else {
						continue
					}
					let location = (x, y % board.dimention)

					guard let value = tile.value else {
						continue
					}
					if tileToLeftHasSameValue(location: location, value: value) {
//						print("-----", location, "has same value", value)
						delegate?.moveTwoTiles(from: (location, (location.0, location.1 - 1)), to: (location.0, location.1 - 1), value: value * 2)
						board.tiles[y]?.removeFromSuperview()
						board.tiles[y] = nil

						board.tiles[y-1]?.value = value * 2
					} else if canOneTileMoveLeft(location: location) {
//						print("can move to left \(location)")
						delegate?.moveOneTile(from: location, to: (location.0, location.1 - 1), value: value)
						board.tiles[rowIndexes].swapAt(y, y - 1)
//						//print(row)
					}
				}
			}
		}
		//printTiles()
	}

	private func right() {
		for _ in 0..<4 {
			for x in 0..<board.dimention { // row
				let rowIndexes = x * board.dimention..<(x + 1) * board.dimention
				var row = board.tiles[rowIndexes]
				for y in rowIndexes.dropLast().reversed() { // column
					guard let tile =  row[y] else {
						continue
					}
					guard let value = tile.value else {
						continue
					}
					let location = (x, y % board.dimention)
					if tileToRightHasSameValue(location: location, value: value) {
						//print("-----", location, "has same value", value)
						delegate?.moveTwoTiles(from: (location, (location.0, location.1 + 1)), to: (location.0, location.1 + 1), value: value * 2)
						board.tiles[y]?.removeFromSuperview()
						board.tiles[y] = nil

						board.tiles[y+1]?.value = value * 2
					} else if canOneTileMoveRight(location: location) {
						//print("can move to right \(location)")
						delegate?.moveOneTile(from: location, to: (location.0, location.1 + 1), value: value)
						board.tiles[rowIndexes].swapAt(y, y + 1)
						//print(row)
					}
				}
			}
		}
		//printTiles()
	}

	private func up() {
		for _ in 0..<4 {
			for x in 0..<board.dimention { // column
				var column = [Tile?]()
				var columnIndexes = [Int]()
				for (idx, tile) in board.tiles.enumerated() {
					if idx % board.dimention == x {
						column.append(tile)
						columnIndexes.append(idx)
					}
				}
				//print("indexes", columnIndexes)
				for (idx, y) in columnIndexes.enumerated() { // row
					guard idx > 0 else {
						continue
					}
					guard let tile =  board.tiles[y] else {
						continue
					}
					guard let value = tile.value else {
						continue
					}
					let location = (y / board.dimention, x)
					//print("location", location)
					if tileAboveHasSameValue(location: location, value: value) {
						delegate?.moveTwoTiles(from: (location, (location.0 - 1, location.1)), to: (location.0 - 1, location.1), value: value * 2)
						board.tiles[y]?.removeFromSuperview()
						board.tiles[y] = nil

						board.tiles[columnIndexes[idx - 1]]?.value = value * 2
					} else if canOneTileMoveUp(location: location) {
						//print("<can move to up \(location)")
						delegate?.moveOneTile(from: location, to: (location.0 - 1, location.1), value: value)
						//print("swap indexes", y, columnIndexes[idx - 1])
						board.tiles.swapAt(y, columnIndexes[idx - 1])
					}
				}
			}
		}
		//printTiles()
	}

	private func down() {
		for _ in 0..<4 {
			for x in 0..<board.dimention { // column
				var column = [Tile?]()
				var columnIndexes = [Int]()
				for (idx, tile) in board.tiles.enumerated() {
					if idx % board.dimention == x {
						column.append(tile)
						columnIndexes.append(idx)
					}
				}
				//print("indexes", columnIndexes)
				for (idx, y) in columnIndexes.enumerated() { // row
					guard idx != board.dimention - 1 else {
						continue
					}
					guard let tile =  board.tiles[y] else {
						continue
					}
					guard let value = tile.value else {
						continue
					}
					let location = (y / board.dimention, x)
					//print("location", location)
					if tileBelowHasSameValue(location: location, value: value) {
						delegate?.moveTwoTiles(from: (location, (location.0 + 1, location.1)), to: (location.0 + 1, location.1), value: value * 2)
						board.tiles[y]?.removeFromSuperview()
						board.tiles[y] = nil
						board.tiles[columnIndexes[idx + 1]]?.value = value * 2
					} else if canOneTileMoveDown(location: location) {
//						//print("<can move to up \(location)")
						delegate?.moveOneTile(from: location, to: (location.0 + 1, location.1), value: value)
//						//print("swap indexes", y, columnIndexes[idx + 1])
						board.tiles.swapAt(y, columnIndexes[idx + 1])
					}
				}
			}
		}
		printTiles()
	}

	private func printTiles() {
		print("<<<<<<<<<<")
		for x in 0..<board.dimention {
			let rowIndexes = x * board.dimention..<(x + 1) * board.dimention
			let row = board.tiles[rowIndexes]
			print(rowIndexes, "\(row)")
		}
	}
}

extension GameController {

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
