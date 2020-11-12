//
//  User.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/05.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation

class User: GitIssueObject, Codable {
    enum CodingKeys: String, CodingKey {
        case no, nickname, image
    }
	
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        no = try values.decode(Int.self, forKey: .no)
        nickname = try values.decode(String?.self, forKey: .nickname)
        image = try values.decode(String?.self, forKey: .image)
    }
	
    var no: Int
    var nickname: String?
    var image: String?
	override var searchText: String { nickname ?? "" }
	override var number: Int { no }
	
	init(no: Int, nickname: String, image: String?) {
		self.no = no
		self.nickname = nickname
		self.image = image
	}
	
	static let all = ["whrlgus", "NamKiBeom"]
		.map {
			User(no: 0,
				 nickname: $0,
				 image: "")
		}
}
