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
	static let spaceBtwTiles: CGFloat = 15

	var backgroundTiles = [Tile]()
	var tiles: [Tile?]
	var tilesRects = [CGRect]()

	init(dimention: Int, boardSize: CGSize) {
		guard boardSize.height == boardSize.width else {
			fatalError("Square board!")
		}
		self.dimention = dimention
		self.tiles = [Tile?](repeating: nil, count: dimention * dimention)
		let sizeLength = (Double(boardSize.height) - Double(Board.spaceBtwTiles) * Double(self.dimention + 1)) / Double(self.dimention)
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
		var point = CGPoint(x: Board.spaceBtwTiles, y: Board.spaceBtwTiles)
		for _ in 0..<dimention  {
			point.x = Board.spaceBtwTiles
			for _ in 0..<dimention {
				let backgroundTile = Tile(radius: Board.radius, size: tileSize, origin: point)
				self.addSubview(backgroundTile)
				backgroundTiles.append(backgroundTile)
				tilesRects.append(backgroundTile.frame)
				point.x += Board.spaceBtwTiles + tileSize.height
			}
			point.y += Board.spaceBtwTiles + tileSize.height
		}
	}
	var emptyTiles: [Tile?] {
		return tiles.filter({$0 == nil})
	}

	subscript(row: Int, column: Int) -> Tile? {
		guard 0..<tiles.count ~= row * dimention + column else {
			return nil
		}
		return tiles[row * dimention + column]
	}

<<<<<<< develop
	func position(location: (Int, Int)) -> CGPoint? {
		guard 0..<tilesPositions.count ~= location.0 * dimention + location.1 else {
			return nil
		}
		return tilesPositions[location.0 * dimention + location.1]
	}

=======
>>>>>>> start bug fixed
	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}
}
