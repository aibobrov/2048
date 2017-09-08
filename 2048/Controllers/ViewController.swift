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
	var resultView: Result.UIType? {
		willSet {
			if newValue == nil {
				resultView?.removeFromSuperview()
				resultView?.blurEffectView.removeFromSuperview()

			}
		}
		didSet {
			if let resultView = resultView {
				resultView.value = score.value
			}
		}
	}
	var retryView: RetryView? {
		willSet {
			if newValue == nil {
				retryView?.removeFromSuperview()
			}
		}
	}
	
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

	}
	
	func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
		
	}
	
	func userDidWon() {
		guard resultView == nil else {
			return
		}
		let rect = CGRect(origin: CGPoint.zero, size: CGSize(width: 200, height: 140))
		resultView = Result.win(frame: rect).view
		resultView?.center = self.view.center
		self.view.addSubview(resultView!)
		self.resultView?.setBlurView()
		self.resultView?.blurEffectView.alpha = 0
		UIView.animate(withDuration: 0.3, animations: {
			self.resultView?.blurEffectView.alpha = 1.0
		}, completion: {_ in
			guard self.retryView == nil, let resultView = self.resultView else {
				return
			}
			let finalPoint = CGPoint(x: resultView.frame.minX, y: resultView.frame.maxY + 16)
			
			self.retryView = RetryView(frame: CGRect(origin: CGPoint(x: finalPoint.x, y: self.view.frame.maxY), size: CGSize(width: resultView.frame.width, height: resultView.frame.height / 2)) , clicked: #selector(self.retryClicked))
			self.view.addSubview(self.retryView!)
			UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 5, options: .curveEaseOut, animations:{
				self.retryView?.frame.origin.y = finalPoint.y
			}, completion: nil)
		})
		
		print("win")
	}
	
	@objc func retryClicked() {
		self.controller.restart()
		retryView = nil
		resultView = nil
		print("retry")
	}
	func userDidLost() {
		guard resultView == nil else {
			return
		}
		let rect = CGRect(origin: CGPoint.zero, size: CGSize(width: 200, height: 140))
		resultView = Result.lose(frame: rect).view
		resultView?.center = self.view.center
		self.view.addSubview(resultView!)
		resultView?.setBlurView()
		print("ended")
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
	}
	// MARK: right
	@objc func swipedRight() {
		controller.restart()
	}
	// MARK: up
	@objc func swipedUp() {

	}
	// MARK: down
	@objc func swipedDown() {
		
	}
}

