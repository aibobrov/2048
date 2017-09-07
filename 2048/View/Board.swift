//
//  Board.swift
//  2048
//
//  Created by Artem Bobrov on 03.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit

class Board: UIView {
	static let boardColor = UIColor(red:0.74, green:0.68, blue:0.62, alpha:1.00)
	static let radius: CGFloat = 7.0
	
	let dimention: Int
	let tileSize: CGSize
	let spaceBtwTiles: CGFloat = 15

	var backgroundTiles = [Tile]()
	var tiles: [Tile?]
	var tilesPositions = [CGPoint]()

	init(dimention: Int, boardSize: CGSize) {
		guard boardSize.height == boardSize.width else {
			fatalError("Square board!")
		}
		self.dimention = dimention
		self.tiles = [Tile?](repeating: nil, count: dimention * dimention)
		let sizeLength = (Double(boardSize.height) - Double(spaceBtwTiles) * Double(self.dimention + 1)) / Double(self.dimention)
		tileSize = CGSize(width: sizeLength, height: sizeLength)
		super.init(frame: CGRect(origin: CGPoint.zero, size: boardSize))
		setupBackGround()
		setupEmptyTiles()
	}


	private func setupBackGround() {
		self.layer.cornerRadius = Board.radius
		self.backgroundColor = Board.boardColor
	}

	private func setupEmptyTiles() {
		var point = CGPoint(x: spaceBtwTiles, y: spaceBtwTiles)
		for _ in 0..<dimention  {
			point.x = spaceBtwTiles
			for _ in 0..<dimention {
				let backgroundTile = Tile(radius: Board.radius, size: tileSize, origin: point)
				self.addSubview(backgroundTile)
				backgroundTiles.append(backgroundTile)
				tilesPositions.append(backgroundTile.frame.origin)
				point.x += spaceBtwTiles + tileSize.height
			}
			point.y += spaceBtwTiles + tileSize.height
		}
	}

	subscript(row: Int, column: Int) -> Tile? {
		guard 0..<tiles.count ~= row * dimention + column else {
			return nil
		}
		return tiles[row * dimention + column]
	}

	func position(location: (Int, Int)) -> CGPoint? {
		guard 0..<tilesPositions.count ~= location.0 * dimention + location.1 else {
			return nil
		}
		return tilesPositions[location.0 * dimention + location.1]
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}

	var emptyTiles: [(Tile?, CGRect)] {
		var result = [(Tile?, CGRect)]()
		for (index, tile) in tiles.enumerated() {
			if tile == nil {
				
				result.append((tile, CGRect(origin: tilesPositions[index], size: tileSize)))
			}
		}
		return result
	}
}
