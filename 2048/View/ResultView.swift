//
//  ResultView.swift
//  2048
//
//  Created by Artem Bobrov on 07.09.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import UIKit
enum Result {
	case win(frame: CGRect)
	case lose(frame: CGRect)

	var view: UIType {
		let resultView = UIType(frame: frameView)
		resultView.label.font = resultView.label.font.withSize(35)
		resultView.score.font = resultView.score.font.withSize(40)
		resultView.mode = self
		switch self {
		case .win( _):
			resultView.label.text = "You win!"
		case .lose( _):
			resultView.label.text = "You lost!"
		}
		return resultView
	}

	var frameView: CGRect {
		switch self {
		case .win(let frame):
			return frame
		case .lose(let frame):
			return frame
		}
	}
	
	class UIType: Score {
		var mode: Result!
		var blurEffectView: UIVisualEffectView
		func setBlurView() {
			guard let superview = self.superview else {
				return
			}
			blurEffectView.frame = superview.bounds
			blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			superview.addSubview(blurEffectView)
			superview.bringSubview(toFront: self)
		}

		override init(frame: CGRect) {
			let blurEffect = UIBlurEffect(style: .regular)
			blurEffectView = UIVisualEffectView(effect: blurEffect)
			super.init(frame: frame)
		}

		deinit {
			self.removeFromSuperview()
			blurEffectView.removeFromSuperview()
		}

		required init?(coder aDecoder: NSCoder) {
			fatalError("coder isn't allowed")
		}
	}
}

