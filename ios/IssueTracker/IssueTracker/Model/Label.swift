//
//  Label.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/05.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

class Label: GitIssueObject, Codable {
	var name: String
	var description: String?
	var color: String
    var no: Int
	override var searchText: String { name }
	override var number: Int { no }
    
    enum CodingKeys: String, CodingKey {
        case color, description, name, no
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String?.self, forKey: .description)
        color = try values.decode(String.self, forKey: .color)
        no = try values.decode(Int.self, forKey: .no)
    }
	
    init(name: String, description: String?, color: String, no: Int) {
		self.name = name
		self.description = description
		self.color = color
        self.no = no
	}
	static let all = ["bug","documentation", "duplicacte", "enhancement", "good first issue", "help wanted", "invalid", "question", "wontfix", "dddddddddddddddd"]
		.map {
			Label(name: $0,
				  description: nil,
				  color: String(format: "#%06X",
								(Int.random(in: 1...255) << 16) + (Int.random(in: 1...255) << 8) + Int.random(in: 1...255)), no: 0)
		}
}
