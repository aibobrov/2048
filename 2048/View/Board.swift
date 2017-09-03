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

	let tiles = [[UIView]]()

	init(dimention: Int, boardSize: CGSize) {
		guard boardSize.height == boardSize.width else {
			fatalError("Square board!")
		}
		self.dimention = dimention
		let sizeLength = (boardSize.height - spaceBtwTiles * 5) / 4
		tileSize = CGSize(width: sizeLength, height: sizeLength)
		super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: boardSize))
		setupBackGround()
		setupTiles()
	}


	private func setupBackGround() {
		self.layer.cornerRadius = radius
		self.backgroundColor = boardColor
	}


	private func setupTiles() {
		var point = CGPoint(x: spaceBtwTiles, y: spaceBtwTiles)
		for x in 0..<dimention  {
			point.x = spaceBtwTiles
			for y in 0..<dimention {
				print(point, "\(x),\(y)")
				let tile = Tile(radius: radius, size: tileSize, origin: point)
				self.addSubview(tile)
				point.x += spaceBtwTiles + tileSize.height
			}
			point.y += spaceBtwTiles + tileSize.height
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}
}
