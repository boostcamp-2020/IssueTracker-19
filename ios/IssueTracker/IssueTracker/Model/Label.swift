//
//  Label.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/05.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

class Label: HashableObject, Codable {
	let name: String
	let description: String?
	let color: String
    
    enum CodingKeys: String, CodingKey {
        case name, description, color
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        color = try values.decode(String.self, forKey: .color)
    }
	
	init(name: String, description: String?, color: String) {
		self.name = name
		self.description = description
		self.color = color
	}
	static let all = ["bug","documentation", "duplicacte", "enhancement", "good first issue", "help wanted", "invalid", "question", "wontfix", "dddddddddddddddd"]
		.map {
			Label(name: $0,
				  description: nil,
				  color: String(format: "#%06X",
								(Int.random(in: 1...255) << 16) + (Int.random(in: 1...255) << 8) + Int.random(in: 1...255)))
		}
}
