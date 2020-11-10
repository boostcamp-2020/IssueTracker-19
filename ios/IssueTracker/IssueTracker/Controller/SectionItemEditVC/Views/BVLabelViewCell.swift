//
//  BVLabelViewCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/10.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class BVLabelViewCell: UICollectionViewCell {
	static var identifier: String {
		Self.self.description()
	}
	
	
	@IBOutlet weak var view: UIView!
	@IBOutlet weak var button: UIButton!
	
	let inset = CGFloat(10)
	
	var titleLabel = UILabel()
	var widthConstraint: NSLayoutConstraint?
	
	var label: Label? {
		didSet {
			guard let label = label else { return }
			titleLabel.text = label.name
			widthConstraint?.isActive = false
			widthConstraint = view.widthAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.width + inset * 2)
			widthConstraint?.priority = UILayoutPriority(999)
			widthConstraint?.isActive = true
			
			let pair = label.color.toUIColorPair()
			view.backgroundColor = pair.0
			titleLabel.textColor = pair.1
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
		
		view.layer.cornerRadius = 3
		view.clipsToBounds = true
		view.addSubview(titleLabel)
		
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.lineBreakMode = .byTruncatingMiddle
		
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
			titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: inset),
			titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset)
		])
		
    }

}
