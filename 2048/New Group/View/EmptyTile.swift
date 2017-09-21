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

	init(position: Position, frame: CGRect) {
		self.position = position
		super.init(frame: frame)
		self.backgroundColor = App.tile(value: nil).color
		self.layer.cornerRadius = 7.0
	}


	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
