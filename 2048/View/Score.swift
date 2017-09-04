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

	var value: Int = 0 {
		didSet {
			score.text = String(value)
		}
	}

	override init(frame: CGRect) {
		label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 3))
		score = UILabel(frame: CGRect(x: 0, y: label.frame.height, width: frame.width, height: frame.height - label.frame.height))
		super.init(frame: frame)

		label.text = "Score"
		label.textAlignment = .center
		label.textColor = UIColor(red:0.91, green:0.87, blue:0.82, alpha:1.00)
		label.font = UIFont(name: "Helvetica-Bold", size: 20)

		score.text = String(value)
		score.textAlignment = .center
		score.textColor = .white
		score.font = UIFont(name: "Helvetica-Bold", size: 30)
		score.numberOfLines = 1
		score.minimumScaleFactor = 10/self.label.font.pointSize
		score.adjustsFontSizeToFitWidth = true

		addSubview(label)
		addSubview(score)
		self.backgroundColor = Board.boardColor
		self.layer.cornerRadius = Board.radius
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}
	

}
