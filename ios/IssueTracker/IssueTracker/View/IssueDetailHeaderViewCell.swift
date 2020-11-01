//
//  IssueDetailHeaderViewCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/01.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class IssueDetailHeaderViewCell: UICollectionViewCell {
	static let identifier = "IssueDetailHeaderViewCell"

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var noLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	
	var issue: Issue? {
		didSet {
			authorLabel.text = issue?.author
			titleLabel.text = issue?.title
			noLabel.text = "#\(issue?.no ?? 0)"
		}
	}
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
		contentView.backgroundColor = .white
    }

}
