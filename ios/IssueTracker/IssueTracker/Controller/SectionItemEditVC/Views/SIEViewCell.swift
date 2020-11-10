//
//  SIEViewCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/10.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class SIEViewCell: UICollectionViewCell {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let button: UIButton = {
		let button = UIButton()
		button.isUserInteractionEnabled = false
		return button
	}()
	
	private func setupViews() {
		contentView.addSubview(button)
		button.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			button.widthAnchor.constraint(equalToConstant: 22)
		])
	}
	
}

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
		return view
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		
		return label
	}()
	
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
	
	private func setupViews() {
		contentView.addSubview(view)
		view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
		])
		
		
		view.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
			titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
		])
	}
}
