//
//  RestartButton.swift
//  2048
//
//  Created by Artem Bobrov on 24.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import UIKit

class RestartButton: UIButton {


	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = App.board.color
		self.layer.cornerRadius = Board.radius
		setTitle("restart", for: .normal)
		setTitleColor(App.text.color, for: .normal)
		titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 17)
		titleLabel?.numberOfLines = 1
		titleLabel?.minimumScaleFactor = 10 / (titleLabel?.font.pointSize)!
		titleLabel?.adjustsFontSizeToFitWidth = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}


}

