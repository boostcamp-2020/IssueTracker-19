//
//  IssueDetailHeaderReusableView.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/01.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

protocol IssueStatusViewComponent {
	var icon: UIImage? { get }
	var text: String { get }
	var darkColor: UIColor { get }
	var normalColor: UIColor { get }
	var lightColor: UIColor { get }
}

struct IssueOpen: IssueStatusViewComponent {
	let icon = UIImage(systemName: "exclamationmark.circle")
	let text = "Open"
	let darkColor = #colorLiteral(red: 0.1583744586, green: 0.6552472711, blue: 0.2697575986, alpha: 1)
	let normalColor = #colorLiteral(red: 0.8636499643, green: 1, blue: 0.8940187097, alpha: 1)
	let lightColor = #colorLiteral(red: 0.9370031953, green: 1, blue: 0.9577273726, alpha: 1)
}

struct IssueClosed: IssueStatusViewComponent {
	let icon = UIImage(systemName: "checkmark.circle")
	let text = "Closed"
	let darkColor = #colorLiteral(red: 0.8402572274, green: 0.2270017564, blue: 0.2884457111, alpha: 1)
	let normalColor = #colorLiteral(red: 0.9983618855, green: 0.8616315722, blue: 0.8771993518, alpha: 1)
	let lightColor = #colorLiteral(red: 0.9940989614, green: 0.935305357, blue: 0.9361984134, alpha: 1)
}

class IssueDetailHeaderReusableView: UICollectionReusableView {
	static var identifier: String {
		Self.self.description()
	}
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var noLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var statusLabel: UILabel!
	@IBOutlet weak var tmpLabel: UILabel!
	
	var issue: Issue! {
		didSet {
			authorLabel.text = issue.author
			titleLabel.text = issue.title
			noLabel.text = "#\(issue.no)"
            setLabel(statusLabel, component: (issue.isOpened != 0) ? IssueOpen() : IssueClosed())
			HTTPAgent.shared.loadImage(urlString: issue.image ?? "") { [weak self] (result) in
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
	
	func setLabel(_ label: UILabel, component: IssueStatusViewComponent) {
		label.layer.borderWidth = 1
		label.layer.borderColor = component.normalColor.cgColor
		label.layer.cornerRadius = 5

		let attachment = NSTextAttachment()
		attachment.image = component.icon?.withTintColor(component.darkColor)

		let fullString = NSMutableAttributedString(attachment: attachment)
		fullString.append(NSAttributedString(string: component.text))

		label.attributedText = fullString
		label.textColor = component.darkColor
		label.layer.backgroundColor = component.lightColor.cgColor
		
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width + 20)
		])

	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		backgroundColor = .tertiarySystemBackground
		imageView.layer.cornerRadius = 10
		imageView.clipsToBounds = true
	}
}
