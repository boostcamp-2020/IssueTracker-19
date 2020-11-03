//
//  IssueDetailBottomViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class IssueDetailBottomViewController: UIViewController {

	@IBOutlet weak var commentButtonView: CornerRoundedFloatingView!
	
	// MARK: - variables for determining view frame
	var statusBarHeight: CGFloat {
		if #available(iOS 13.0, *) {
			let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
			return  window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 20
		} else {
			return UIApplication.shared.statusBarFrame.height
		}
	}
	let screenHeight = UIScreen.main.bounds.height
	lazy var minTop = screenHeight - (commentButtonView.frame.maxY + 20)
	lazy var maxTop = statusBarHeight * 2
	
	// MARK: - life cycle
	override func viewDidLoad() {
        super.viewDidLoad()
	
		view.frame.size.height = screenHeight - maxTop
		view.frame.origin.y = screenHeight
		let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
		view.addGestureRecognizer(gesture)
    }
	
	
	func showViewWithAnimation() {
		UIView.animate(withDuration: 0.4, animations: { [weak self] in
			guard let viewController = self else { return }
			viewController.view.frame.origin.y = viewController.minTop
		})
	}
	
	@objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
		let translation = recognizer.translation(in: view)
		let posY = view.frame.minY
		let nPosY = posY + translation.y
		if nPosY < maxTop || minTop < nPosY { return }
		
		self.view.frame.origin.y = nPosY
		recognizer.setTranslation(.zero, in: view)
		
		let velocity = recognizer.velocity(in: view)
		if recognizer.state == .ended {
			UIView.animate(withDuration: 0.4) {
				if velocity.y < -400 {
					self.view.frame.origin.y = self.maxTop
				} else if velocity.y > 400 {
					self.view.frame.origin.y = self.minTop
				} else {
					self.view.frame.origin.y = nPosY < self.screenHeight / 2 ? self.maxTop : self.minTop
				}
			} completion: { _ in
				print(self.view.frame.minY)
			}
		}
	}
	
	@IBAction func addCommentAction(_ sender: UIButton) {
	}
	@IBAction func upButtonAction(_ sender: UIButton) {
	}
	@IBAction func downButtonAction(_ sender: UIButton) {
	}
}

extension IssueDetailViewController {
	
}
