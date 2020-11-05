//
//  Label.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/05.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

struct Label: Hashable, Codable {
    let identifier: UUID
    
    static func == (lhs: Label, rhs: Label) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    enum CodingKeys: String, CodingKey {
        case name, description, color
    }
    
    init(from decoder: Decoder) throws {
        identifier = UUID()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        color = try values.decode(String.self, forKey: .color)
    }
    var name: String
    var description: String?
    var color: String
}
