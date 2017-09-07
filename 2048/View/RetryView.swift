//
//  RetryView.swift
//  2048
//
//  Created by Artem Bobrov on 07.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit

class RetryView: UIView {
	// FIXME: trouble with retryButton(doesn't appear)
	var retryButton: UIButton
	// FIXME: selector troubles
	init(frame: CGRect, clicked: Selector) {
		retryButton = UIButton(frame: frame)
//		let titleLabel = UILabel(frame: frame)
		super.init(frame: frame)
		self.layer.cornerRadius = Board.radius

		retryButton.setTitle("Retry", for: .normal)
		self.backgroundColor = Board.boardColor
		retryButton.addTarget(self, action: clicked, for: .touchUpInside)
		addSubview(retryButton)
//		retryButton.act
	}

	deinit {
		self.removeFromSuperview()
		retryButton.removeFromSuperview()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("coder isn't allowed")
	}

}
