//
//  Board.swift
//  2048
//
//  Created by Artem Bobrov on 03.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit

class Board: UIView {
	let dimention: Int
	let boardColor = UIColor(red:0.74, green:0.68, blue:0.62, alpha:1.00)
	let tileSize: CGSize
	let spaceBtwTiles: CGFloat = 15
	let radius: CGFloat = 10.0

	var tiles = [[UIView]]()

	init(dimention: Int, boardSize: CGSize) {
		guard boardSize.height == boardSize.width else {
			fatalError("Square board!")
		}
		self.dimention = dimention
		let sizeLength = (Double(boardSize.height) - Double(spaceBtwTiles) * Double(self.dimention + 1)) / Double(self.dimention)
		tileSize = CGSize(width: sizeLength, height: sizeLength)
		super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: boardSize))
		setupBackGround()
		setupEmptyTiles()
	}


	private func setupBackGround() {
		self.layer.cornerRadius = radius
		self.backgroundColor = boardColor
	}

	private func setupEmptyTiles() {
		var point = CGPoint(x: spaceBtwTiles, y: spaceBtwTiles)
		for x in 0..<dimention  {
			point.x = spaceBtwTiles
			tiles.append([])
			for _ in 0..<dimention {
				let tile = Tile(radius: radius, size: tileSize, origin: point)
				self.addSubview(tile)

				tiles[x].append(tile)
				point.x += spaceBtwTiles + tileSize.height
			}
			point.y += spaceBtwTiles + tileSize.height
		}
	}

	subscript(row: Int, column: Int) -> Tile {
		return tiles[row][column]
	}



	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}
}
