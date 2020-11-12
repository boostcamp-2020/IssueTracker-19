//
//  NotificationName.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/11.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

extension Notification.Name {
	static let googleLoginSuccess = Notification.Name("googleLoginSuccess")
	static let didIssueDetailEditFinish = Notification.Name("didIssueDetailEditFinish")
	static let didClickCommentButton = Notification.Name("didClickCommentButton")
	static let didCommentAdd = Notification.Name("didCommentAdd")
	static let didClickBottomViewCloseIssueButton = Notification.Name("didClickBottomViewCloseIssueButton")
	static let didClickBottomViewEditButton = Notification.Name("didClickBottomViewEditButton")
}
