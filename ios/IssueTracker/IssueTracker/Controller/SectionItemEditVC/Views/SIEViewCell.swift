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
	
	var item: GitIssueObject?
	
	let button: UIButton = {
		let button = UIButton()
		button.isUserInteractionEnabled = false
		return button
	}()
	
	private func setupViews() {
		backgroundColor = .tertiarySystemBackground
		contentView.backgroundColor = .tertiarySystemBackground
		contentView.addSubview(button)
		button.translatesAutoresizingMaskIntoConstraints = false
		
		let height = contentView.heightAnchor.constraint(equalToConstant: 60)
		height.priority = .defaultLow
		NSLayoutConstraint.activate([
			height,
			button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			button.widthAnchor.constraint(equalToConstant: 22)
		])
	}
	
}
