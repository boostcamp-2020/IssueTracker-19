//
//  SectionItem.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/02.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

class SectionItem: Hashable {
	let identifier = UUID()
	
	static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
		return lhs.identifier == rhs.identifier
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}
}
