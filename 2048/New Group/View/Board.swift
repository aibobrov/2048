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
	
	let dimension: Int
	let tileSize: CGSize
	var spaceBtwTiles: CGFloat = 8
	var tileRects = [CGRect]()

	init(dimension: Int, offsetBtwTiles: CGFloat, boardSize: CGSize) {
		guard boardSize.height == boardSize.width else {
			fatalError("Square board!")
		}
		self.dimension = dimension
		self.spaceBtwTiles = offsetBtwTiles

		let sizeLength = (Double(boardSize.height) - Double(spaceBtwTiles) * Double(self.dimension + 1)) / Double(self.dimension)
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
		for x in 0..<dimension  {
			point.x = spaceBtwTiles
			for y in 0..<dimension {
				let backgroundTile = EmptyTile(position: Position(x, y), frame: CGRect(origin: point, size: tileSize))
				self.addSubview(backgroundTile)
				tileRects.append(backgroundTile.frame)
				
				point.x += spaceBtwTiles + tileSize.height
			}
			point.y += spaceBtwTiles + tileSize.height
		}
	}

	func positionRect(position: Position) -> CGRect {
		return tileRects[position.x * dimension + position.y]
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}
}
