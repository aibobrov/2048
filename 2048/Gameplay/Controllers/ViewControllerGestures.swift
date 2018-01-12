//
//  ViewControllerGestures.swift
//  2048
//
//  Created by Artem Bobrov on 12.01.2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit


// MARK: Gestures
extension ViewController {
	func setupGestures() {
		let left = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
		left.direction = .left
		let right = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
		right.direction = .right
		let up = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
		up.direction = .up
		let down = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
		down.direction = .down

		self.view.addGestureRecognizer(left)
		self.view.addGestureRecognizer(right)
		self.view.addGestureRecognizer(up)
		self.view.addGestureRecognizer(down)
	}
	// MARK: left
	@objc func swipedLeft() {
		manager.shift(to: .left)
	}

	// MARK: right
	@objc func swipedRight() {
		manager.shift(to: .right)
	}

	// MARK: up
	@objc func swipedUp() {
		manager.shift(to: .up)
	}

	// MARK: down
	@objc func swipedDown() {
		manager.shift(to: .down)
	}
}
