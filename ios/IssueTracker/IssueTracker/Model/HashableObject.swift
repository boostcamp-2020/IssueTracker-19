//
//  HashableObject.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/08.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

class HashableObject: Hashable {
	let identifier = UUID()
	
	static func == (lhs: HashableObject, rhs: HashableObject) -> Bool {
		return lhs.identifier == rhs.identifier
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}
}
