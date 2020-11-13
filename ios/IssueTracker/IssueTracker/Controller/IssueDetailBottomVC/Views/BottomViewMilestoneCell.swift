//
//  BottomViewMilestoneCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/08.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class SectionCell: UICollectionViewCell {
	var item: GitIssueObject?
}

class BottomViewMilestoneCell: SectionCell {
	static var identifier: String {
		Self.self.description()
	}

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var progressView: UIProgressView!
	@IBOutlet weak var dueDateLabel: UILabel!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	
	override var item: GitIssueObject? {
		didSet {
			guard let milestone = item as? Milestone else { return }
			titleLabel.text = milestone.title
			
			progressView.progress = 0
			if milestone.totalTasks != 0 {
				progressView.progress = Float(milestone.closedTasks) / Float(milestone.totalTasks)
			}
			
			if let dueDate = milestone.dueDate {
				dueDateLabel.text = "Due by \(dueDate.description)"
				bottomConstraint.constant = 10
			} else {
				dueDateLabel.text = nil
				bottomConstraint.constant = 6
			}
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		backgroundColor = .tertiarySystemBackground
		layer.cornerRadius = 10
		progressView.layer.cornerRadius = 4
		progressView.clipsToBounds = true
    }

}
