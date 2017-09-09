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
	@IBAction func restartButtonClicked(_ sender: UIButton) {
		controller.restart()
	}
}
extension ViewController: GameControllerDelegate {
	func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int) {
		UIView.animate(withDuration: 0.1,  delay: 0.01 * Double(from.1), options: .curveEaseOut, animations: {
			guard let toRect = self.board.tileRect(location: to) else {
				return
			}
			self.board[from.0, from.1]?.frame = toRect
		}, completion: { finished in
//			//print(finished, "From \(from) To \(to)")
		})
	}
	
	func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
		let (x1, y1) = from.0
		let (x2, y2) = from.1
		UIView.animate(withDuration: 0.2, animations: {
			guard let toRect = self.board.tileRect(location: to) else {
				return
			}
			self.board[x1, y1]?.frame = toRect
			self.board[x2, y2]?.frame = toRect
		}, completion: { finished in
//			//print(finished, "From [\(from.0), \(from.1)] To \(to)")
			guard finished else {
				return
			}
			// to tile
			let tile = self.board[x2, y2]
			UIView.animate(withDuration: 2, animations: {
				tile?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
			}, completion: { finished in
				tile?.transform = CGAffineTransform.identity
			})
		})
	}
	
	func userDidWon() {
		//print("win")
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
		controller.move(to: .left)
	}
	// MARK: right
	@objc func swipedRight() {
		controller.move(to: .right)
//		self.moveTwoTiles(from: ((0, 0), (0, 1)), to: (0, 3), value: 4)
//		self.moveOneTile(from: (0, 0), to: (0, 3), value: 2)
//		self.moveOneTile(from: (1, 0), to: (1, 3), value: 2)
	}
	// MARK: up
	@objc func swipedUp() {
		controller.move(to: .up)
	}
	// MARK: down
	@objc func swipedDown() {
//		controller.restart()
		controller.move(to: .down)
	}
}


