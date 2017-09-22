//
//  GameController.swift
//  2048
//
//  Created by Artem Bobrov on 04.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit

class GameLogicManager {
	private var tiles = [Tile]() {
		didSet {
			refreshNeighborTiles()
		}
	}
	var dimension: Int
	private var winTileValue: Int

	var score: Int = 0 {
		didSet {
			delegate?.scoreDidChanged(to: score)
		}
	}
	var delegate: GameLogicManagerDelegate?

	private var updating = false

	var isGameEnded: Bool {
		return isUserWon || isUserLost
	}

	var isUserLost: Bool = false {
		didSet {
			if isUserLost {
				delegate?.userDidLost()
			}
		}
	}
	var isUserWon: Bool = false {
		didSet{
			if isUserWon {
				delegate?.userDidWon()
			}
		}
	}

	private var newTileValue: Int {
		let rnd = arc4random() % 10
		return rnd < 2 ? 4 : 2
	}

	init(dimension: Int, winValue: Int) {
		self.dimension = dimension
		self.winTileValue = winValue
		start()
	}

	private func reset() {
		score = 0
		isUserWon = false
		isUserLost = false
		tiles.removeAll(keepingCapacity: true)
		for row in 0..<dimension {
			for column in 0..<dimension {
				tiles.append(Tile(position: Position( row, column)))
			}
		}
		refreshNeighborTiles()
	}

	func start() {
		reset()
		delegate?.didCreatedTile(randomTile)
		delegate?.didCreatedTile(randomTile)
	}

	private var randomTile: Tile? {
		if let position = randomPosition(), let tile = tiles.filter({$0.position == position}).first {
			tile.value = newTileValue
			return tile
		}
		return nil
	}

	private func isGameOver() -> Bool {
		if tiles.filter({$0.value == nil}).count != 0 {
			return false
		}
		for tile in tiles {
			let v = tile.value!
			let neighbours = [tile.upTile, tile.rightTile, tile.bottomTile, tile.leftTile].filter { $0?.value == v }
			if neighbours.count != 0 {
				return false
			}
		}
		return true
	}

	private func randomPosition() -> Position? {
		let emptyTiles = tiles.filter({$0.value == nil})
		return emptyTiles[Int(arc4random_uniform(UInt32(emptyTiles.count)))].position
	}

	private func refreshNeighborTiles() {
		for tile in tiles {
			let up = Position(tile.position.x, tile.position.y - 1)
			tile.upTile = tiles.filter({$0.position == up}).first

			let bottom = Position(tile.position.x, tile.position.y + 1)
			tile.bottomTile = tiles.filter({$0.position == bottom}).first

			let left = Position(tile.position.x - 1, tile.position.y)
			tile.leftTile = tiles.filter({$0.position == left}).first

			let right = Position(tile.position.x + 1, tile.position.y)
			tile.rightTile = tiles.filter({$0.position == right}).first
		}

	}



	func shift(to direction: MoveDirection) {
		if updating {
			return
		}
		updating = true
		var waitForSignalToContinue = false

		var performedShift = false
		for rowOrColumn in 0..<dimension {
			var tilesToCheck = tiles.filter {
				return ((direction == .right || direction == .left) ? $0.position.x : $0.position.y) == rowOrColumn
			}
			if direction == .right || direction == .down {
				tilesToCheck = tilesToCheck.reversed()
			}


			var tileIndex = 0
			while tileIndex < tilesToCheck.count {
				let currentTile = tilesToCheck[tileIndex]
				let filter: ((_ tile: Tile) -> Bool) = { tile in
					let position: Bool = {
						switch direction {
						case .up: return tile.position.x > currentTile.position.y
						case .right: return tile.position.y < currentTile.position.y
						case .down: return tile.position.x < currentTile.position.x
						case .left: return tile.position.y > currentTile.position.y
						}
					}()
					return position && tile.value != nil
				}

				if let otherTile = tilesToCheck.filter(filter).first {
					if otherTile.value == currentTile.value {
						waitForSignalToContinue = true
						moveOnSameTile(from: otherTile, to: currentTile)
						score += currentTile.value!
						if currentTile.value! == winTileValue {
							delegate?.userDidWon()
							return
						}
						performedShift = true
					} else if currentTile.value == nil {
						waitForSignalToContinue = true
						moveOnEmptyTile(from: otherTile, to: currentTile)
						tileIndex -= 1
						performedShift = true
					}
				}
				tileIndex += 1
			}
		}
		if performedShift {
			delegate?.didCreatedTile(randomTile)
		}
		isUserLost = isGameOver()

		if !waitForSignalToContinue {
			updating = false
		}
	}

	private func moveOnSameTile(from sourceTile: Tile, to destinationTile: Tile) {
		destinationTile.value! *= 2
		sourceTile.value = nil
		delegate?.didMoveTile(from: sourceTile, to: destinationTile, completion: {
			self.updating = false
		})
	}

	private func moveOnEmptyTile(from sourceTile: Tile, to destinationTile: Tile) {
		destinationTile.value = sourceTile.value
		sourceTile.value = nil
		delegate?.didMoveTile(from: sourceTile, to: destinationTile.position, completion: {
			self.updating = false
		})
	}

}
