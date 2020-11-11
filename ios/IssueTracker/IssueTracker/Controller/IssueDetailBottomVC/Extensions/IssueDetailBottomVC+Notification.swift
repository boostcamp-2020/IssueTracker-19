//
//  IssueDetailBottomVC+Notification.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/11.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

extension IssueDetailBottomViewController {
	func configureNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(onDidFinishEdit), name: .didIssueDetailEditFinish, object: nil)
		
	}
	
	@objc func onDidFinishEdit(_ notification: Notification) {
		mainView.isUserInteractionEnabled = true
		gestureRecognizer?.isEnabled = true
		
		guard let selected = notification.userInfo?["selected"] as? [GitIssueObject],
			  let type = notification.object as? BottomViewSection else { return }

		if let items = selected as? [User], type == .assignee {
			assignees = items
		}else if let items = selected as? [Label], type == .label {
			labels = items
		}else if let items = selected as? [Milestone], type == .milestone {
			milestones = items
		}
		applySnapshot()
	}
	
}
