//
//  IssueDetailCommentViewCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/01.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit
import MarkdownView

class IssueDetailCommentViewCell: UICollectionViewCell {
	static var identifier: String {
		Self.self.description()
	}

	@IBOutlet weak var markdownHeight: NSLayoutConstraint!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var createdAtLabel: UILabel!
	
	@IBOutlet weak var mdContentView: UIView!
	
	var issueComment: Comment? {
		didSet {
			guard let comment = issueComment else { return }
			authorLabel.text = comment.author
			createdAtLabel.text = comment.updatedAt
			
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
	
	weak var wrapper: MarkdownWrapper? {
		didSet {
			mdContentView.subviews.forEach{ $0.removeFromSuperview() }
			markdownHeight.constant = 0
			guard let wrapper = wrapper, let height = wrapper.height else {
				return
			}
			wrapper.markdown.removeFromSuperview()
			markdownHeight.constant = height + 50
			print(height)
			mdContentView.addSubview(wrapper.markdown)
			wrapper.markdown.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				wrapper.markdown.leadingAnchor.constraint(equalTo: mdContentView.leadingAnchor),
				wrapper.markdown.topAnchor.constraint(equalTo: mdContentView.topAnchor),
				wrapper.markdown.bottomAnchor.constraint(equalTo: mdContentView.bottomAnchor),
				wrapper.markdown.trailingAnchor.constraint(equalTo: mdContentView.trailingAnchor)
			])
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
