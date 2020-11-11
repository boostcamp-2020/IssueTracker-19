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
		print(#function)
	}
	
	@IBAction func upButtonAction(_ sender: UIButton) {
		print(#function)
	}
	@IBAction func downButtonAction(_ sender: UIButton) {
		print(#function)
	}
	
	func sectionHeaderEditButtonAction(idx: Int?) {
		
		guard let idx = idx,
			  let type = BottomViewSection(rawValue: idx)
		else { return }
		
		let editSectionItemVC = SectionItemEditViewController(bottomViewSection: type)
		
		switch type {
		case .assignee:
			editSectionItemVC.original = assignees
		case .label:
			editSectionItemVC.original = labels
		case .milestone:
			editSectionItemVC.original = milestones
		}
		
		
		addChild(editSectionItemVC)
		editSectionItemVC.view.frame = view.bounds
		view.addSubview(editSectionItemVC.view)
		editSectionItemVC.didMove(toParent: self)
		editSectionItemVC.navItem.title = type.text

		mainView.isUserInteractionEnabled = false
		gestureRecognizer?.isEnabled = false
	}
	
	func closeButtonAction() {
		print("close issue")
	}
}
