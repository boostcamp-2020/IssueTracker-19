//
//  TitleSupplementaryView.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/10.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class SIEHeaderView: UICollectionReusableView {
	let label: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .footnote)
		label.textColor = .systemGray
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}
	
	func configure() {
		addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		let bottomConstraint = label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
		bottomConstraint.priority = .defaultLow
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			label.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			bottomConstraint
		])
	}
}

