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

class SIEFooterView: UICollectionReusableView {
	let label: UILabel = {
		let label = UILabel()
		label.textColor = .systemGray
		return label
	}()
	
	let topSeparator: UIView = {
		let view = UIView()
		view.backgroundColor = .separator
		return view
	}()
	
	let bottomSeparator: UIView = {
		let view = UIView()
		view.backgroundColor = .separator
		return view
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}
	
	func configure() {
		backgroundColor = .tertiarySystemBackground
		
		addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		let heightConstraint = heightAnchor.constraint(equalToConstant: 60)
		heightConstraint.priority = .defaultLow
		NSLayoutConstraint.activate([
			heightConstraint,
			label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			label.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
		
		addSubview(topSeparator)
		topSeparator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topSeparator.topAnchor.constraint(equalTo: topAnchor),
			topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
			topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
			topSeparator.heightAnchor.constraint(equalToConstant: 0.5)
		])
		
		addSubview(bottomSeparator)
		bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			bottomSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
			bottomSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
			bottomSeparator.bottomAnchor.constraint(equalTo: bottomAnchor),
			bottomSeparator.heightAnchor.constraint(equalToConstant: 0.5)
		])
	}
}
