//
//  Tile.swift
//  2048
//
//  Created by Artem Bobrov on 03.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit

class Tile: UIView {
	var value: Int? {
		didSet {
			if  let number = value, number != 0 {
				self.label.isHidden = false
				self.label.text = String(number)
				self.backgroundColor = UIColor.blue
			} else {
				self.label.isHidden = true
			}
		}
	}

	let label : UILabel

	init(radius: CGFloat, size: CGSize, origin: CGPoint = CGPoint(x: 0, y: 0)) {
		self.label = UILabel(frame: CGRect(origin: origin, size: size))
		self.label.adjustsFontSizeToFitWidth = true
		self.label.adjustsFontForContentSizeCategory = true
		super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
		self.backgroundColor = UIColor.blue
		self.addSubview(label)
		self.layer.cornerRadius = radius
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}
}
