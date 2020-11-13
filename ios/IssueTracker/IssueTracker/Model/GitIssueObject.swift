//
//  HashableObject.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/08.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

class GitIssueObject: Hashable {
	let identifier = UUID()
	var searchText: String {
		""
	}
	var number: Int {
		0
	}
	
	static func == (lhs: GitIssueObject, rhs: GitIssueObject) -> Bool {
		return lhs.identifier == rhs.identifier
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}
}
