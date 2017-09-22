//
//  ViewController.swift
//  2048
//
//  Created by Artem Bobrov on 02.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var manager: GameLogicManager!
	var score: Score!
	var highScore: HighScore!
	var renderer: GameBoardRenderer!

	override func viewDidLoad() {
		super.viewDidLoad()

		let dimension = 4
		let board = Board(dimension: dimension, boardSize: CGSize(width: self.view.frame.width - (Board.spaceBtwTiles + 1)  * 2, height:  self.view.frame.width - (Board.spaceBtwTiles + 1) * 2))
		board.center = self.view.center
		self.view.addSubview(board)
		
		manager = GameLogicManager(dimension: dimension, winValue: 2048)
		manager.delegate = self

		renderer = GameBoardRenderer(board: board)

		let offset: CGFloat = 15
		let scoreSize = CGSize(width: 100, height: 70)
		let scorePoint = CGPoint(x: (view.frame.width + board.frame.width) / 2 - scoreSize.width, y: 50)
		score = Score(frame: CGRect(origin: scorePoint, size: scoreSize))
		self.view.addSubview(score)

		let highScorePoint = CGPoint(x: scorePoint.x - scoreSize.width - offset, y: scorePoint.y)
		highScore = HighScore(frame: CGRect(origin: highScorePoint, size: scoreSize))
		self.view.addSubview(highScore!)

		setupGestures()
		manager.start()
	}
}

extension ViewController: GameLogicManagerDelegate {
	func userDidLost() {
		let alert = UIAlertController(title: "You win", message: "I've reached 2048!", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
			self.renderer.reset()
			self.manager.start()
		}))
		self.present(alert, animated: true, completion: nil)
	}

	func scoreDidChanged(to score: Int) {
		self.score.value = score
		if highScore.value < score {
			self.highScore.value = score
		}
	}

	func userDidWon() {
		let alert = UIAlertController(title: "You win", message: "I've reached 2048!", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

	func didCreatedTile(_ tile: Tile?) {
		guard let tile = tile else {
			return
		}
		renderer.add(tile: tile)
	}

	func didMoveTile(from source: Tile, to destination: Tile, completion: @escaping () -> Void) {
		renderer.move(from: source, to: destination, completion: completion)
	}

	func didMoveTile(from source: Tile, to destination: Position, completion: @escaping () -> Void) {
		renderer.move(from: source, to: destination, completion: completion)
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


