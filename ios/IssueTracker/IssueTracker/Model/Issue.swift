//
//  Issue.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/29.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

struct User: Codable {
    
}

struct Label: Codable {
    
}

class Issue: SectionItem {
    var no: Int
    var title: String
    var author: String
    var assignees: [User]
    var labels: [Label]
    var isOpened: Bool
    var createdAt: Date
    var closedAt: Date?
    var milestone: Milestone?
    var commentCount: Int

	init(no: Int,
		 title: String,
		 author: String,
		 assignees: [User],
		 labels: [Label],
		 isOpened: Bool,
		 createdAt: Date,
		 closedAt: Date?,
		 milestone: Milestone?,
		 commentCount: Int) {
		self.no = no
		self.title = title
		self.author = author
		self.assignees = assignees
		self.labels = labels
		self.isOpened = isOpened
		self.createdAt = createdAt
		self.closedAt = closedAt
		self.milestone = milestone
		self.commentCount = commentCount
	}
}

class SampleIssue: SectionItem {
    var text = "#3"
}
