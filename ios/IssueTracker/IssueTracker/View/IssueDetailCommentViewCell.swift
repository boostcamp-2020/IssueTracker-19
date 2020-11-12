//
//  IssueDetailCommentViewCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/01.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class IssueDetailCommentViewCell: UICollectionViewCell {
	static var identifier: String {
		Self.self.description()
	}

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var createdAtLabel: UILabel!
	@IBOutlet weak var contentLabel: UILabel!
	
	var issueComment: Comment? {
		didSet {
			guard let comment = issueComment else { return }
			authorLabel.text = comment.author
			createdAtLabel.text = comment.updatedAt
			contentLabel.text = comment.content
			HTTPAgent.shared.loadImage(urlString: comment.image ?? "") { [weak self] (result) in
				switch result {
				case .success(let path):
					DispatchQueue.main.async {
						self!.imageView.image = UIImage(contentsOfFile: path)
					}
				case .failure(let error):
					print(error)
				}
			}
			
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
		contentView.backgroundColor = .tertiarySystemBackground
		imageView.layer.cornerRadius = 20
		imageView.clipsToBounds = true
    }
	
	@IBAction func editButtonAction(_ sender: UIButton) {
		NotificationCenter.default.post(name: .didClickCommentOptionButton, object: issueComment)
	}
}
