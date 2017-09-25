//
//  AppColor.swift
//  2048
//
//  Created by Artem Bobrov on 17.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit

enum App {

	case board
	case tile(value: Int?)
	case tileText(value: Int?)
	case text
	case plusText
	static let emptyColor = UIColor(white: 1.0, alpha: 0.4)
	var color: UIColor {

		switch self {
		case .board:
			return UIColor(red:0.74, green:0.68, blue:0.62, alpha:1.00)
		case .tile(let value):
			guard let value = value else {
				return UIColor(white: 1.0, alpha: 0.4) // empty color
			}
			switch value {
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
		case .tileText(let value):
			guard let value = value else {
				return UIColor.clear
			}
			let dark = UIColor(red:0.47, green:0.43, blue:0.39, alpha:1.00)
			let white = UIColor.white
			switch value {
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
		case .text:
			return UIColor(white: 1, alpha: 0.7)
		case .plusText:
			return UIColor(red:0.91, green:0.87, blue:0.82, alpha: 0.5)
		}
	}
}
