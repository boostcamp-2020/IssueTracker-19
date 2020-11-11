//
//  SIELabelViewCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/10.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class SIELabelViewCell: SIEViewCell {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let view: UIView = {
		let view = UIView()
		view.backgroundColor = .blue
		view.clipsToBounds = true
		view.layer.cornerRadius = 3
		return view
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.lineBreakMode = .byTruncatingMiddle
		return label
	}()
	
	var widthConstraint: NSLayoutConstraint?
	let inset = CGFloat(10)
	override var item: GitIssueObject? {
		didSet {
			guard let item = item as? Label else { return }
			titleLabel.text = item.name
			widthConstraint?.isActive = false
			widthConstraint = view.widthAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.width + inset * 2)
			widthConstraint?.priority = UILayoutPriority(999)
			widthConstraint?.isActive = true
			
			let pair = item.color.toUIColorPair()
			view.backgroundColor = pair.0
			titleLabel.textColor = pair.1
		}
	}

	private func setupViews() {
		contentView.addSubview(view)
		view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			view.trailingAnchor.constraint(lessThanOrEqualTo: button.leadingAnchor, constant: -20)
		])
		
		view.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
			titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: inset),
			titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset / 2),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset / 2)
		])
	}
}
