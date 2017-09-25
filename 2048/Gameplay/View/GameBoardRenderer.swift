//
//  GameBoardRenderer.swift
//  2048
//
//  Created by Artem Bobrov on 21.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit

class GameBoardRenderer {
	var board: Board
	private var tileViews = [TileView]()
	let moveSpeed = 0.1
	init(board: Board) {
		self.board = board
	}

	func reset() {
		for view in tileViews {
			view.removeFromSuperview()
		}
		tileViews.removeAll(keepingCapacity: false)
	}


	func failedShifting(to direction: MoveDirection) {
		let delta: CGFloat = 30
		var deltaPoint: CGPoint {
			switch direction {
			case .up:
				return CGPoint(x: 0, y: -delta)
			case .down:
				return CGPoint(x: 0, y: delta)
			case .left:
				return CGPoint(x: -delta, y: 0)
			case .right:
				return CGPoint(x: delta, y: 0)
			}
		}
		for tile in tileViews {
			UIView.animate(withDuration: moveSpeed, animations: {
				tile.frame.origin = tile.frame.origin + deltaPoint
			}, completion: { _ in
				UIView.animate(withDuration: 0.1, animations: {
					tile.frame.origin = tile.frame.origin - deltaPoint
				})
			})
		}
	}

	func move(from sourceTile: Tile, to destinationTile: Tile, completion: @escaping () -> Void) {
		let sourceTileView = tileViews.filter({$0.position == sourceTile.position}).first!
		let destinationTileView = tileViews.filter({$0.position == destinationTile.position}).first!
		board.bringSubview(toFront: sourceTileView)

		UIView.animate(withDuration: moveSpeed, delay: 0, options: .curveEaseInOut, animations: {
			sourceTileView.center = destinationTileView.center
			sourceTileView.position = destinationTile.position
			destinationTileView.alpha = 0

			sourceTileView.value = destinationTile.value!
		}) { (finished) -> Void in
			guard finished else {
				return
			}

			UIView.animate(withDuration: 0.05, animations: {
				sourceTileView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
			}, completion: { finished in
				sourceTileView.transform = CGAffineTransform.identity
			})

			destinationTileView.alpha = 0
			destinationTileView.removeFromSuperview()
			if let index = self.tileViews.index(of: destinationTileView) {
				self.tileViews.remove(at: index)
			}
			completion()
		}
	}

	func move(from tile: Tile, to position: Position, completion: @escaping () -> Void) {
		let tileView = tileViews.filter({$0.position == tile.position}).first!
		UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
			tileView.frame.origin = self.board.positionRect(position: position).origin
			tileView.position = position
		}) { _ in
			completion()
		}
	}
	
	func add(tile: Tile) {
		let tileView = TileView(value: tile.value!, position: tile.position, frame: board.positionRect(position: tile.position))
		board.addSubview(tileView)
		board.bringSubview(toFront: tileView)
		
		// appearance animation
		let scale: CGFloat = 0.25
		tileView.transform = CGAffineTransform(scaleX: scale, y: scale)
		tileView.alpha = 0
		UIView.animate(withDuration: 0.2, animations: {
			tileView.transform = CGAffineTransform(scaleX: 1, y: 1)
			tileView.alpha = 1.0
		})
		
		tileViews.append(tileView)
	}

}

