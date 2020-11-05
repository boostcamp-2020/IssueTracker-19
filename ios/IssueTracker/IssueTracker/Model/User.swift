//
//  User.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/05.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

struct User: Hashable, Codable {
    let identifier: UUID
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    enum CodingKeys: String, CodingKey {
        case no, nickname, image
    }
    init(from decoder: Decoder) throws {
        identifier = UUID()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        no = try values.decode(Int.self, forKey: .no)
        nickname = try values.decode(String.self, forKey: .nickname)
        image = try values.decode(String?.self, forKey: .image)
    }
    var no: Int
    var nickname: String
    var image: String?
}
