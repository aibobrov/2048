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
	var plusScoreView: UILabel

	var value: Int = 0 {
		didSet {
			score.text = String(value)
			if value - oldValue > 0 {
				plusScoreView.isHidden = false
				plusScoreView.text = "+\(value - oldValue)"
				let oldOrigin = plusScoreView.frame.origin
				let oldAlpha = plusScoreView.alpha
				UIView.animate(withDuration: 0.5, animations: {
					self.plusScoreView.frame.origin.y = self.score.center.y + 10
					self.plusScoreView.alpha = 0
				}, completion: { (_) in
					self.plusScoreView.isHidden = true
					self.plusScoreView.frame.origin = oldOrigin
					self.plusScoreView.alpha = oldAlpha
				})
			}
		}
	}

	override init(frame: CGRect) {
		label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 3))
		score = UILabel(frame: CGRect(x: 0, y: label.frame.height, width: frame.width, height: frame.height - label.frame.height))
		let delta = 10
		let plusScoreViewSize = CGSize(width: score.frame.width - CGFloat(delta), height: score.frame.height / 3)
		plusScoreView = UILabel(frame: CGRect(origin: CGPoint(x: score.frame.maxX - plusScoreViewSize.width - CGFloat(delta) / 2, y: score.frame.maxY - plusScoreViewSize.height - CGFloat(delta) / 2), size: plusScoreViewSize))
		super.init(frame: frame)

		setupLabel()
		setupScore()
		setupPlusScore()

		addSubview(label)
		addSubview(score)
		addSubview(plusScoreView)
		bringSubview(toFront: plusScoreView)

		self.backgroundColor = Board.boardColor
		self.layer.cornerRadius = Board.radius
	}

	private func setupPlusScore() {
		plusScoreView.text = ""
		plusScoreView.textAlignment = .right
		plusScoreView.backgroundColor = UIColor.clear
		plusScoreView.textColor = UIColor(red:0.91, green:0.87, blue:0.82, alpha: 0.5)
		plusScoreView.font = UIFont(name: "Helvetica-Bold", size: 15)
	}

	private func setupLabel() {
		label.text = "Score"
		label.textAlignment = .center
		label.textColor = UIColor(red:0.91, green:0.87, blue:0.82, alpha:1.00)
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
