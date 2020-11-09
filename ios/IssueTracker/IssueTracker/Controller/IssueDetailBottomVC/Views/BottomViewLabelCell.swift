//
//  BottomViewLabelCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/08.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class BottomViewLabelCell: SectionCell {
	static var identifier: String {
		Self.self.description()
	}

	@IBOutlet weak var titleLabel: UILabel!
	
	override var item: GitIssueObject? {
		didSet {
			guard let label = item as? Label else { return }
			titleLabel.text = label.name
			let pair = label.color.toUIColorPair()
			backgroundColor = pair.0
			titleLabel.textColor = pair.1
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		layer.cornerRadius = 3
		clipsToBounds = true
    }

}
