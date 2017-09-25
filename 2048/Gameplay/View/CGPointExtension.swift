//
//  CGPointExtension.swift
//  2048
//
//  Created by Artem Bobrov on 23.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
	static func +(one: CGPoint, other: CGPoint) -> CGPoint {
		return CGPoint(x: one.x + other.x, y: one.y + other.y)
	}

	static func -(one: CGPoint, other: CGPoint) -> CGPoint {
		return CGPoint(x: one.x - other.x, y: one.y - other.y)
	}
}
