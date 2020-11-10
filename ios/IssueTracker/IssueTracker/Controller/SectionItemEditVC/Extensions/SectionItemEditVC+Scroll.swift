//
//  SectionItemEditVC+Scroll.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/09.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

// MARK: - Configure Bottom View's PanGesture
extension SectionItemEditViewController {
	func configureScrollAction() {
		let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
		view.addGestureRecognizer(gesture)
	}
	
	@objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
		let translation = recognizer.translation(in: view)
		let posY = view.frame.minY
		var nPosY = posY + translation.y
		if nPosY < topSpace && translation.y < 0 {
			nPosY -= (translation.y + 2)
			nPosY = max(nPosY, -topSpace)
		}

		self.view.frame.origin.y = nPosY
		recognizer.setTranslation(.zero, in: view)
		

		let velocity = recognizer.velocity(in: view)
		if recognizer.state == .ended {
			UIView.animate(withDuration: 0.4) { [weak self] in
				guard let controller = self else { return }
				if velocity.y > 400 {
					controller.view.frame.origin.y = controller.height
				} else {
					controller.view.frame.origin.y = nPosY < controller.height / 2 ?
						controller.topSpace : controller.height
				}
			} completion: { [weak self] _ in
				guard let controller = self else { return }
				if controller.view.frame.origin.y == controller.height {
					controller.remove()
				}
			}
		}
	}
}
