//
//  BottomViewAssigneeCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/08.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class BottomViewAssigneeCell: SectionCell {
	static var identifier: String {
		Self.self.description()
	}

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var nicknameLabel: UILabel!
	@IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
	
	override var item: HashableObject? {
		didSet {
			guard let user = item as? User else { return }
			nicknameLabel.text = user.nickname
			imageView.image = UIImage(systemName: "person.crop.rectangle.fill")
			imageView.layer.cornerRadius = imageWidthConstraint.constant / 2
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
	
    }

}
