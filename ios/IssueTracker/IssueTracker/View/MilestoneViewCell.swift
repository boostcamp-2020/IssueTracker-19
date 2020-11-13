//
//  MilestoneViewCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/04.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class MilestoneViewCell: UICollectionViewCell {
	static var identifier: String {
		Self.self.description()
	}
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var dueDateLabel: UILabel!
	@IBOutlet weak var progressLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var openTasksLabel: UILabel!
	@IBOutlet weak var closedTasksLabel: UILabel!
	@IBOutlet weak var badgeView: UIView!
	
	var milestone: Milestone? {
		didSet {
			guard let milestone = milestone else { return }
			titleLabel.text = milestone.title
			dueDateLabel.text = milestone.dueDate?.description ?? ""
			var progress = 0
			if milestone.totalTasks != 0 {
				progress = Int(Float(milestone.closedTasks) / Float(milestone.totalTasks) * 100)
			}
			progressLabel.text = "\(progress)%"
			descriptionLabel.text = milestone.description ?? ""
			openTasksLabel.text = "\(milestone.totalTasks - milestone.closedTasks) open"
			closedTasksLabel.text = "\(milestone.closedTasks) closed"
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
		backgroundColor = .tertiarySystemBackground
		dueDateLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: dueDateLabel.intrinsicContentSize.width).isActive = true
		badgeView.layer.cornerRadius = 10
		badgeView.layer.borderWidth = 1
		badgeView.layer.borderColor = UIColor.lightGray.cgColor
    }

}
