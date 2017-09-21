//
//  EmptyTile.swift
//  2048
//
//  Created by Artem Bobrov on 20.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit

class EmptyTile: UIView {
	var position: Position

	let emptyColor: UIColor = UIColor(white: 1.0, alpha: 0.4)

	init(size: CGSize) {
		self.position = Position.Nil
		super.init(frame: CGRect(origin: CGPoint.zero, size: size))
		self.backgroundColor = emptyColor
		self.layer.cornerRadius = Board.radius
	}

	init(position: Position, size: CGSize, origin: CGPoint = CGPoint.zero) {
		self.position = position
		super.init(frame: CGRect(origin: origin, size: size))
		self.backgroundColor = emptyColor
		self.layer.cornerRadius = Board.radius
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
