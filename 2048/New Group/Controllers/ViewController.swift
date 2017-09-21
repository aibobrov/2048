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
	var manager: GameLogicManager!
	var score: Score!

	override func viewDidLoad() {
		super.viewDidLoad()
		let dimentions = 4
		board = Board(dimention: dimentions, boardSize: CGSize(width: self.view.frame.width - (Board.spaceBtwTiles + 1)  * 2, height:  self.view.frame.width - (Board.spaceBtwTiles + 1) * 2))
		board.center = self.view.center
		self.view.addSubview(board)
		
		manager = GameLogicManager(dimentions: dimentions, winValue: 2048)
		manager.delegate = self

		let scoreSize = CGSize(width: 100, height: 70)
		let scorePoint = CGPoint(x: (view.frame.width + board.frame.width) / 2 - scoreSize.width, y: 50)
		score = Score(frame: CGRect(origin: scorePoint, size: scoreSize))
		self.view.addSubview(score)

		setupGestures()
		manager.start()
	}
}

extension ViewController: GameLogicManagerDelegate {
	func userDidLost() {
		print("User lost")
	}

	func scoreDidChanged(to score: Int) {
		self.score.value = score
	}

	func userDidWon() {
		print("User won")
	}

	func didCreatedTile(_ tile: Tile?) {
		// renderer
		print("Created on Position: \(tile?.position.ToString())")
	}

	func didMoveTile(from source: Tile, to destination: Tile, completion: @escaping () -> Void) {
		print("Move from \(source.position.ToString()) to \(destination.position.ToString())")
	}

	func didMoveTile(from source: Tile, to destination: Position, completion: @escaping () -> Void) {
		print("Move from \(source.position.ToString()) to \(destination.ToString())")
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


