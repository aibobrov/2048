//
//  ViewControllerGameLogicManagerDelegates.swift
//  2048
//
//  Created by Artem Bobrov on 12.01.2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit

// MARK: Source
extension ViewController: GameSourceDelegate {
	func boardValuesChanged(to tiles: [Tile]) {
		ModelController.shared.save(dimension: manager.dimension, tiles: tiles)
	}
}

extension ViewController: GameLogicManagerDelegate {
	func nothingChangedShift(to direction: MoveDirection) {
		renderer.failedShifting(to: direction)
	}

	func userDidLost() {
		let alert = UIAlertController(title: "You've Lost", message: "Try next time!", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
			self.renderer.reset()
			self.manager.restart()
		}))
		self.present(alert, animated: true, completion: nil)
	}

	func scoreDidChanged(to score: Int) {
		self.score.value = score
		ModelController.shared.save(currentScore: score, for: manager.dimension)
		if highScore.value < score {
			self.highScore.value = score
			ModelController.shared.save(highScore: score, for: manager.dimension)
		}

	}

	func userDidWon() {
		/*
		// uncomment to enable "congratulation" notification
		let alert = UIAlertController(title: "You win", message: "I've reached \(winValue)!", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
		self.present(alert, animated: true, completion: nil)
		*/
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

