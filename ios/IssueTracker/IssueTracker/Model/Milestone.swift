//
//  Milestone.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/04.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

class Milestone: SectionItem {
	let no: Int
	let title: String
	let totalTasks: Int
	let closedTasks: Int
	let isClosed: Bool
	let isDeleted: Bool
	let dueDate: Date?
	let description: String?
	init(no: Int,
		 title: String,
		 totalTasks: Int,
		 closedTasks: Int,
		 isClosed: Bool,
		 isDeleted: Bool,
		 dueDate: Date?,
		 description: String?) {
		self.no = no
		self.title = title
		self.totalTasks = totalTasks
		self.closedTasks = closedTasks
		self.isClosed = isClosed
		self.isDeleted = isDeleted
		self.dueDate = dueDate
		self.description = description
	}
}
