//
//  ViewController.swift
//  2048
//
//  Created by Artem Bobrov on 02.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var board: Board!
	var controller: GameController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		board = Board(dimention: 4, boardSize: CGSize(width: 343, height: 343))
		board.center = self.view.center
		self.view.addSubview(board)

		controller = GameController(board: board)
		controller.delegate = self
		setupGestures()
		controller.start()
	}
}
extension ViewController: GameControllerDelegate {
	func userDidLost() {
		print("ended")
	}

}

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

	}
	// MARK: right
	@objc func swipedRight() {

	}
	// MARK: up
	@objc func swipedUp() {

	}
	// MARK: down
	@objc func swipedDown() {

	}
}

