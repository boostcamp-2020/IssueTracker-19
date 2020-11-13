//
//  IssueDetailBottomVC+ButtonAction.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/09.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

// MARK: - User Event Handler
extension IssueDetailBottomViewController {
	@IBAction func addCommentAction(_ sender: UIButton) {
		UIView.animate(withDuration: 0.4) { [weak self] in
			guard let controller = self else { return }
			controller.view.frame.origin.y = controller.minTop
		} completion: { [weak self] _ in
			guard let controller = self else { return }
			controller.topConstraint?.constant = controller.view.frame.origin.y
			NotificationCenter.default.post(name: .didClickCommentButton, object: nil)
		}
	}
	
	@IBAction func upButtonAction(_ sender: UIButton) {
		NotificationCenter.default.post(name: .shouldScrollUp, object: nil)
	}
	@IBAction func downButtonAction(_ sender: UIButton) {
		NotificationCenter.default.post(name: .shouldScrollDown, object: nil)
	}
	
	
	
}
