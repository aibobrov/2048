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
	var score: Score!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		board = Board(dimention: 4, boardSize: CGSize(width: self.view.frame.width - (Board.spaceBtwTiles + 1)  * 2, height:  self.view.frame.width - (Board.spaceBtwTiles + 1) * 2))
		board.center = self.view.center
		self.view.addSubview(board)
		
		controller = GameController(board: board)
		controller.delegate = self
		
		let scoreSize = CGSize(width: 100, height: 70)
		let scorePoint = CGPoint(x: (view.frame.width + board.frame.width) / 2 - scoreSize.width, y: 30)
		score = Score(frame: CGRect(origin: scorePoint, size: scoreSize))
		self.view.addSubview(score)

		setupGestures()
		controller.restart()
	}
}
extension ViewController: GameControllerDelegate {
	func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int) {
		print("From \(from) -> To \(to)")
		UIView.animate(withDuration: 0.2, animations: {
			guard let toRect = self.board.tileRect(location: to) else {
				return
			}
			self.board[from.0, from.1]?.frame = toRect
		}, completion: nil)
	}
	
	func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
		
	}
	
	func userDidWon() {
		print("win")
	}
	
	@objc func retryClicked() {

	}

	func userDidLost() {

	}
	
	func scoreDidChanged(to score: Int) {
		self.score.value = score
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
		controller.restart()
	}
	// MARK: right
	@objc func swipedRight() {
		controller.move(to: .right)
	}
	// MARK: up
	@objc func swipedUp() {

	}
	// MARK: down
	@objc func swipedDown() {
		
	}
}

