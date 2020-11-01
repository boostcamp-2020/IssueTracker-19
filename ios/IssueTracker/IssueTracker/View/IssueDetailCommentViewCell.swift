//
//  IssueDetailCommentViewCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/01.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class IssueDetailCommentViewCell: UICollectionViewCell {
	static let identifier = "IssueDetailCommentViewCell"

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var createdAtLabel: UILabel!
	@IBOutlet weak var contentLabel: UILabel!
	
	var issueComment: IssueComment? {
		didSet {
			authorLabel.text = issueComment?.author
			contentLabel.text = issueComment?.content
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
		contentView.backgroundColor = .white
    }
	@IBAction func editButtonAction(_ sender: UIButton) {
	}
	
}
