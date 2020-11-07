//
//  Milestone.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/04.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

class Milestone: HashableObject, Codable {
	let no: Int
	let title: String
	let totalTasks: Int
	let closedTasks: Int
	let isClosed: Bool
	let isDeleted: Bool
	let dueDate: Date?
	let description: String?
	
	init(no: Int, title: String, totalTasks: Int, closedTasks: Int, isClosed: Bool, isDeleted: Bool, dueDate: Date?, description: String?) {
		self.no = no
		self.title = title
		self.totalTasks = totalTasks
		self.closedTasks = closedTasks
		self.isClosed = isClosed
		self.isDeleted = isDeleted
		self.dueDate = dueDate
		self.description = description
	}
	
	static let all = [
		Milestone(no: 1, title: "스프린트2", totalTasks: 36, closedTasks: 23, isClosed: false, isDeleted: false, dueDate: Date(), description: "이번 배포를 위한 스프린트"),
		Milestone(no: 2, title: "스프린트3", totalTasks: 0, closedTasks: 0, isClosed: false, isDeleted: false, dueDate: nil, description: "다음 배포를 위한 스프린트"),
		Milestone(no: 3, title: "스프린트4", totalTasks: 10, closedTasks: 8, isClosed: false, isDeleted: false, dueDate: Date(), description: "아주 다음 배포를 위한 스프린트")]
}
