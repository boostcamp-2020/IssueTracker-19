//
//  Milestone.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/04.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

struct Milestone: Hashable, Codable {
    static func == (lhs: Milestone, rhs: Milestone) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    var identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
	let no: Int
	let title: String
	let totalTasks: Int
	let closedTasks: Int
	let isClosed: Bool
	let isDeleted: Bool
	let dueDate: Date?
	let description: String?
}
