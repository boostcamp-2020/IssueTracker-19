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
	
	override var item: GitIssueObject? {
		didSet {
			guard let user = item as? User else { return }
			HTTPAgent.shared.loadImage(urlString: user.image ?? "") { [weak self] (result) in
				switch result {
				case .success(let path):
					DispatchQueue.main.async {
						self?.imageView.image = UIImage(contentsOfFile: path)
					}
				case .failure(let error):
					print(error)
				}
			}
			
			nicknameLabel.text = user.nickname
			imageView.image = UIImage(systemName: "person.crop.rectangle.fill")
			imageView.layer.cornerRadius = imageWidthConstraint.constant / 2
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
	
    }

}
