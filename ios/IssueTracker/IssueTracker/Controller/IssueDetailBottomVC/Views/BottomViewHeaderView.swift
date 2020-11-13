//
//  IssueDetailSectionHeaderView.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/07.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class BottomViewHeaderView: UICollectionReusableView {
	static var identifier: String {
		Self.self.description()
	}
	
	var sectionIdx: Int?
	
	@IBOutlet weak var titleLabel: UILabel!
	
	@IBAction func editButtonAction(_ sender: UIButton) {
		NotificationCenter.default.post(name: .didClickBottomViewEditButton, object: sectionIdx)
	}
	
}
