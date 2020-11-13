//
//  IssueDetailBottomVC+Scroll.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/09.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

// MARK: - Configure Bottom View's PanGesture
extension IssueDetailBottomViewController {
	func configureScrollAction() {
		let recognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction))
		view.addGestureRecognizer(recognizer)
		gestureRecognizer = recognizer
		
		NotificationCenter.default.addObserver(self,
											   selector: #selector(rotated),
											   name: UIDevice.orientationDidChangeNotification,
											   object: nil)
	}
	
	@objc func panGestureAction(_ recognizer: UIPanGestureRecognizer) {
		let translation = recognizer.translation(in: view)
		let posY = view.frame.minY
		let nPosY = posY + translation.y
		print(posY)
		if nPosY < maxTop || minTop < nPosY { return }
		
		self.view.frame.origin.y = nPosY
		recognizer.setTranslation(.zero, in: view)
		
		let velocity = recognizer.velocity(in: view)
		if recognizer.state == .ended {
			UIView.animate(withDuration: 0.4) { [weak self] in
				guard let controller = self else { return }
				if velocity.y < -400 {
					controller.view.frame.origin.y = controller.maxTop
				} else if velocity.y > 400 {
					controller.view.frame.origin.y = controller.minTop
				} else {
					controller.view.frame.origin.y = nPosY < controller.screenHeight / 2 ?
						controller.maxTop : controller.minTop
				}
			} completion: { [weak self] _ in
				guard let controller = self else { return }
				controller.isBelow = controller.view.frame.origin.y == controller.minTop
				controller.topConstraint?.constant = controller.view.frame.origin.y
			}
		}
	}
	
	@objc func rotated() {
		topConstraint?.constant = isBelow ? minTop : maxTop
		heightConstraint?.constant = -maxTop
	}
}
