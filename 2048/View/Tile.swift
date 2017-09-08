//
//  Tile.swift
//  2048
//
//  Created by Artem Bobrov on 03.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit

class Tile: UIView {

	var tileColor: UIColor {
		switch value! {
		case 2:
			return UIColor(red:0.94, green:0.89, blue:0.85, alpha:1.00)
		case 4:
			return UIColor(red:0.93, green:0.88, blue:0.78, alpha:1.00)
		case 8:
			return UIColor(red:0.98, green:0.68, blue:0.45, alpha:1.00)
		case 16:
			return UIColor(red:1.00, green:0.55, blue:0.35, alpha:1.00)
		case 32:
			return UIColor(red:1.00, green:0.42, blue:0.33, alpha:1.00)
		case 64:
			return UIColor(red:1.00, green:0.25, blue:0.12, alpha:1.00)
		case 128:
			return UIColor(red:0.94, green:0.82, blue:0.41, alpha:1.00)
		case 256:
			return UIColor(red:0.94, green:0.82, blue:0.34, alpha:1.00)
		case 512:
			return UIColor(red:0.94, green:0.80, blue:0.25, alpha:1.00)
		case 1024:
			return UIColor(red:0.94, green:0.78, blue:0.16, alpha:1.00)
		case 2048:
			return UIColor(red:0.94, green:0.78, blue:0.00, alpha:1.00)
		default:
			return UIColor(red:0.24, green:0.23, blue:0.19, alpha:1.00)
		}
	}

	var tileTextColor: UIColor {
		let dark = UIColor(red:0.47, green:0.43, blue:0.39, alpha:1.00)
		let white = UIColor.white
		switch value! {
		case 2:
			return dark
		case 4:
			return dark
		case 8:
			return white
		case 16:
			return white
		case 32:
			return white
		case 64:
			return white
		case 128:
			return white
		case 256:
			return white
		case 512:
			return white
		case 1024:
			return white
		case 2048:
			return white
		default:
			return white
		}
	}

	var value: Int? {
		didSet {
			if  let number = value, number != 0 {
				self.label.isHidden = false
				self.label.text = String(number)
				self.backgroundColor = tileColor
				self.label.textColor = tileTextColor
			} else {
				self.label.isHidden = true
				self.backgroundColor = emptyColor
			}
		}
	}

	var isEmpty: Bool {
		return value == nil || value == 0
	}

	let emptyColor = UIColor(white: 1.0, alpha: 0.4)
	let label : UILabel

	init(radius: CGFloat, size: CGSize, origin: CGPoint = CGPoint.zero) {
		self.label = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
		super.init(frame: CGRect(origin: origin, size: size))
		self.label.textAlignment = .center
		self.label.numberOfLines = 1
		self.label.font = UIFont(name: "Helvetica-Bold", size: self.frame.height * 2 / 3)
		self.label.minimumScaleFactor = 1/self.label.font.pointSize
		self.label.adjustsFontSizeToFitWidth = true
		self.backgroundColor = emptyColor
		self.addSubview(label)
		self.layer.cornerRadius = radius
	}
<<<<<<< develop

	deinit {
		self.removeFromSuperview()
	}

=======
	
>>>>>>> start bug fixed
	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}
}
