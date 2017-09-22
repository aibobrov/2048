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
	var renderer: GameBoardRenderer!

	override func viewDidLoad() {
		super.viewDidLoad()
		let dimentions = 4
		board = Board(dimention: dimentions, boardSize: CGSize(width: self.view.frame.width - (Board.spaceBtwTiles + 1)  * 2, height:  self.view.frame.width - (Board.spaceBtwTiles + 1) * 2))
		board.center = self.view.center
		self.view.addSubview(board)
		
		manager = GameLogicManager(dimentions: dimentions, winValue: 2048)
		manager.delegate = self

		renderer = GameBoardRenderer(board: board)

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
		guard let tile = tile else {
			return
		}
//		print("Created on Position: \(tile.position.ToString())")
		renderer.add(tile: tile)
	}

	func didMoveTile(from source: Tile, to destination: Tile, completion: @escaping () -> Void) {
//		print("Move from \(source.position.ToString()) to \(destination.position.ToString())")
		renderer.move(from: source, to: destination, completion: completion)
	}

	func didMoveTile(from source: Tile, to destination: Position, completion: @escaping () -> Void) {
//		print("Move from \(source.position.ToString()) to \(destination.ToString())")
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
		checkValues()
		manager.shift(to: .up)
		checkValues()
	}
	// MARK: right
	@objc func swipedRight() {
		checkValues()
		manager.shift(to: .down)
		checkValues()
	}
	// MARK: up
	@objc func swipedUp() {
		checkValues()
		manager.shift(to: .left)
		checkValues()
	}
	// MARK: down
	@objc func swipedDown() {
		checkValues()
		manager.shift(to: .right)
		checkValues()
	}


	func checkValues() {
		for tile in manager.tiles {
			print("Tile:: \(tile.position), \(tile.value ?? -1)")
		}
		print()
		for view in renderer.tileViews {
			print("View:: \(view.position) \(view.value)")
		}
	}
}


