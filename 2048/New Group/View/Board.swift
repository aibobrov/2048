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

	var tiles: [Tile]
	var tilesRects = [CGRect]()

	init(dimention: Int, boardSize: CGSize) {
		guard boardSize.height == boardSize.width else {
			fatalError("Square board!")
		}
		self.dimention = dimention

		let sizeLength = (Double(boardSize.height) - Double(Board.spaceBtwTiles) * Double(self.dimention + 1)) / Double(self.dimention)
		tileSize = CGSize(width: sizeLength, height: sizeLength)
		self.tiles = [Tile](repeating: Tile(tileSize), count: dimention * dimention)
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
		for x in 0..<dimention  {
			point.x = Board.spaceBtwTiles
			for y in 0..<dimention {
				let backgroundTile = Tile(position: Position(x, y), size: tileSize, origin: point)
				self.addSubview(backgroundTile)
				tilesRects.append(backgroundTile.frame)
				point.x += Board.spaceBtwTiles + tileSize.height
			}
			point.y += Board.spaceBtwTiles + tileSize.height
		}
	}
	subscript(row: Int, column: Int) -> Tile {
		return tiles[row * dimention + column]
	}

	subscript(index: Int) -> Tile? {
		return tiles[index]
	}

	func tileRect(location: (Int, Int)) -> CGRect? {
		return tilesRects[location.0 * dimention + location.1]
	}

	func removeFromBoard(at index: Int) {
		self.tiles[index].removeFromSuperview()
		self.tiles[index].
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}

	static func ~=(location: (Int, Int), board: Board) -> Bool {
		let (x, y) = location
		return 0..<board.dimention ~= x && 0..<board.dimention ~= y
	}
}
