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

struct Milestone: Codable {
    
}
class Issue: SectionItem, Codable {
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
}

class SampleIssue: SectionItem {
    var text = "#3"
}
