//
//  Issue.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/29.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

class Comment: GitIssueObject, Codable {
	let no: Int
	let author: String
	let authorNo: Int
	let content: String
	let updatedAt: String
	let image: String?
	
	enum CodingKeys: String, CodingKey {
		case no, author, authorNo, content, updatedAt, image
	}
	
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		no = try values.decode(Int.self, forKey: .no)
		author = try values.decode(String.self, forKey: .author)
		authorNo = try values.decode(Int.self, forKey: .authorNo)
		content = try values.decode(String.self, forKey: .content)
		updatedAt = try values.decode(String.self, forKey: .updatedAt)
		image = try values.decode(String?.self, forKey: .image)
	}
}

struct IssueUserNo: Codable {
	let issueNo: Int
	let userNo: Int
}

struct IssueLabelNo: Codable {
	let issueNo: Int
	let labelNo: Int
}

struct Issue2: Codable {
	let no: Int
	let title: String
	let author: String
	let assignees: [IssueUserNo]?
	let labels: [IssueLabelNo]?
	let isOpened: Int
	let createdAt: String
	let closedAt: String?
	let milestone: Milestone?
	let comments: [Comment]?
}



class Issue: GitIssueObject, Codable {
    
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
    
    init(title: String, author: String) {
        no = 0
        self.title = title
        self.author = author
        assignees = []
        labels = []
        isOpened = 1
        createdAt = "\(Date())"
        commentCount = 1
        closedAt = nil
        milestoneNo = nil
        milestoneTitle = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case no, title, author, assignees, labels, isOpened, createdAt, closedAt, milestoneNo, milestoneTitle, commentCount
    }
	required init(from decoder: Decoder) throws {
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
