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
	var restartButton: RestartButton!
	override func viewDidLoad() {
		super.viewDidLoad()

		let dimension = 4
		setDimention(to: dimension)
		setupGestures()

		manager.start()
//		self.clearSubviews()
//		self.setDimention(to: self.manager.dimension + 1)
	}

	@objc private func restartGame() {
		let alert = UIAlertController(title: "Are sure to start new game?", message: "Current results will be lost", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
			self.renderer.reset()
			self.manager.start()
		}))
		alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

	private func setDimention(to dimension: Int) {
		let spaceBtwTiles: CGFloat = 13
		let board = Board(dimension: dimension, offsetBtwTiles: spaceBtwTiles, boardSize: CGSize(width: self.view.frame.width - (spaceBtwTiles + 1)  * 2, height:  self.view.frame.width - (spaceBtwTiles + 1) * 2))
		board.center = self.view.center
		self.view.addSubview(board)

		manager = GameLogicManager(dimension: dimension, winValue: 2048)
		manager.delegate = self

		renderer = GameBoardRenderer(board: board)

		let offset: CGFloat = board.frame.minX
		let scoreSize = CGSize(width: 100, height: 50)
		let scorePoint = CGPoint(x: (view.frame.width + board.frame.width) / 2 - scoreSize.width, y: 20)
		score = Score(frame: CGRect(origin: scorePoint, size: scoreSize))
		self.view.addSubview(score)

		let highScorePoint = CGPoint(x: scorePoint.x - scoreSize.width - offset, y: scorePoint.y)
		highScore = HighScore(frame: CGRect(origin: highScorePoint, size: scoreSize))
		highScore.value = ModelController.shared.loadHighScore(for: dimension)
		self.view.addSubview(highScore!)

		restartButton = RestartButton(frame: CGRect(origin: CGPoint(x: scorePoint.x, y: score.frame.maxY + offset / 2), size: CGSize(width: scoreSize.width, height: scoreSize.height / 2)))

		restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
		self.view.addSubview(restartButton)
	}

	private func clearSubviews() {
		self.view.subviews.forEach({$0.removeFromSuperview()})
	}
}

extension ViewController: GameLogicManagerDelegate {
	func nothingChangedShift(to direction: MoveDirection) {
		renderer.failedShifting(to: direction)
	}

	func userDidLost() {
		let alert = UIAlertController(title: "You Lost", message: "Try next time!", preferredStyle: .alert)
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
			ModelController.shared.save(highScore: score, for: manager.dimension)
		}
	}

	func userDidWon() {
//		let alert = UIAlertController(title: "You win", message: "I've reached 2048!", preferredStyle: .alert)
//		alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
//		self.present(alert, animated: true, completion: nil)
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


