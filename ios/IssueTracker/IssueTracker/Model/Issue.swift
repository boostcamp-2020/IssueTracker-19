//
//  Issue.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/29.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

struct Issue: Hashable, Codable {
    let uuid: UUID
    
    static func == (lhs: Issue, rhs: Issue) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    let no: Int
    let title: String
    let author: String
    let assignees: [User]
    let labels: [Label]
    let isOpened: Int
    let createdAt: String
    let closedAt: String?
    let milestoneNo: Int?
    let milestoneTitle: String?
    let commentCount: Int
    enum CodingKeys: String, CodingKey {
        case no, title, author, assignees, labels, isOpened, createdAt, closedAt, milestoneNo, milestoneTitle, commentCount
    }
    init(from decoder: Decoder) throws {
        uuid = UUID()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        no = try values.decode(Int.self, forKey: .no)
        title = try values.decode(String.self, forKey: .title)
        assignees = try values.decode([User].self, forKey: .assignees)
        labels = try values.decode([Label].self, forKey: .labels)
        author = try values.decode(String.self, forKey: .author)
        isOpened = try values.decode(Int.self, forKey: .isOpened)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        closedAt = try values.decode(String?.self, forKey: .closedAt)
        milestoneNo = try values.decode(Int?.self, forKey: .milestoneNo)
        milestoneTitle = try values.decode(String?.self, forKey: .milestoneTitle)
        commentCount = try values.decode(Int.self, forKey: .commentCount)
    }
}
