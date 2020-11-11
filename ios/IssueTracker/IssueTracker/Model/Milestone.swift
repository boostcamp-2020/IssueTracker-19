//
//  Milestone.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/04.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

class Milestone: GitIssueObject, Codable {
	let no: Int
	let title: String
	let totalTasks: Int
	let closedTasks: Int
	let isClosed: Int
	let isDeleted: Int
	let dueDate: String?
	let description: String?
	override var searchText: String { title }
	override var number: Int { no }
	
	enum CodingKeys: String, CodingKey {
		case no, title, totalTasks, closedTasks, isClosed, isDeleted, dueDate, description
	}
	
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		no = try values.decode(Int.self, forKey: .no)
		totalTasks = try values.decode(Int.self, forKey: .totalTasks)
		closedTasks = try values.decode(Int.self, forKey: .closedTasks)
		isClosed = try values.decode(Int.self, forKey: .isClosed)
		isDeleted = try values.decode(Int.self, forKey: .isDeleted)
		title = try values.decode(String.self, forKey: .title)
		dueDate = try values.decode(String?.self, forKey: .dueDate)
		description = try values.decode(String?.self, forKey: .description)
	}
	
	init(no: Int, title: String, totalTasks: Int, closedTasks: Int, isClosed: Int, isDeleted: Int, dueDate: String?, description: String?) {
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
		Milestone(no: 1, title: "스프린트2", totalTasks: 36, closedTasks: 23, isClosed: 0, isDeleted: 0, dueDate: "Date()", description: "이번 배포를 위한 스프린트"),
		Milestone(no: 2, title: "스프린트3", totalTasks: 0, closedTasks: 0, isClosed: 0, isDeleted: 0, dueDate: nil, description: "다음 배포를 위한 스프린트"),
		Milestone(no: 3, title: "스프린트4", totalTasks: 10, closedTasks: 8, isClosed: 0, isDeleted: 0, dueDate: "Date()", description: "아주 다음 배포를 위한 스프린트")]
}
