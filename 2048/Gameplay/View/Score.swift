//
//  Score.swift
//  2048
//
//  Created by Artem Bobrov on 04.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit

class Score: UIView {
	var label: UILabel
	var score: UILabel

	var plusScoreAnimationFinished = true
	private var plusScoreQueue = Queue<Int>()

	var value: Int = 0 {
		didSet {
			score.text = String(value)
			let difference = value - oldValue
			if difference > 0 {
				if (self.plusScoreAnimationFinished){
					self.plusScoreAnimation(with: self.newPlusScoreView(for: difference))
				} else {
					self.plusScoreQueue.enqueue(difference)
				}
			}
		}
	}

	private func plusScoreAnimation(with plusScoreView: UILabel) {
		plusScoreAnimationFinished = false
		plusScoreView.isHidden = false
		let oldOrigin = plusScoreView.frame.origin
		let oldAlpha = plusScoreView.alpha
		UIView.animate(withDuration: 0.5, animations: {
			plusScoreView.frame.origin.y = self.score.center.y + 10
			plusScoreView.alpha = 0
		}, completion: { (isFinished) in
			plusScoreView.isHidden = true
			plusScoreView.frame.origin = oldOrigin
			plusScoreView.alpha = oldAlpha
			self.plusScoreAnimationFinished = true
			plusScoreView.removeFromSuperview()
		})
		if (!plusScoreQueue.isEmpty) {
			plusScoreAnimation(with: self.newPlusScoreView(for: plusScoreQueue.dequeue()!))
		}
	}

	override init(frame: CGRect) {
		label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 2 ))
		score = UILabel(frame: CGRect(x: 0, y: label.frame.height, width: frame.width, height: frame.height - label.frame.height))

		super.init(frame: frame)

		setupLabel()
		setupScore()

		addSubview(score)
		addSubview(label)

		self.backgroundColor = App.board.color
		self.layer.cornerRadius = Board.radius
	}


	private func newPlusScoreView(for value: Int) -> UILabel {
		let delta = 10
		let plusScoreViewSize = CGSize(width: score.frame.width - CGFloat(delta), height: score.frame.height * 0.4)
		let plusScoreView = UILabel(frame: CGRect(origin: CGPoint(x: score.frame.maxX - plusScoreViewSize.width - CGFloat(delta) / 2, y: score.frame.maxY - plusScoreViewSize.height - CGFloat(delta) / 2), size: plusScoreViewSize))
		plusScoreView.text = "+\(value)"
		plusScoreView.textAlignment = .right
		plusScoreView.backgroundColor = UIColor.clear
		plusScoreView.textColor = App.plusText.color
		plusScoreView.font = UIFont(name: "Helvetica-Bold", size: 13)
		plusScoreView.numberOfLines = 1
		plusScoreView.minimumScaleFactor = 10 / plusScoreView.font.pointSize
		plusScoreView.adjustsFontSizeToFitWidth = true

		addSubview(plusScoreView)
		bringSubview(toFront: plusScoreView)
		return plusScoreView
	}

	private func setupLabel() {
		label.text = "Score"
		label.textAlignment = .center
		label.textColor = App.text.color
		label.font = UIFont(name: "Helvetica-Bold", size: 20)
		label.numberOfLines = 1
		label.minimumScaleFactor = 10 / self.label.font.pointSize
		label.adjustsFontSizeToFitWidth = true
	}

	private func setupScore() {
		score.text = String(value)
		score.textAlignment = .center
		score.textColor = .white
		score.font = UIFont(name: "Helvetica-Bold", size: 30)
		score.numberOfLines = 1
		score.minimumScaleFactor = 10 / self.label.font.pointSize
		score.adjustsFontSizeToFitWidth = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}
	

}
