//
//  SIEMilestoneViewCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/11.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class SIEMilestoneViewCell: SIEViewCell {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 16)
		return label
	}()
	
	let dueDateLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	override var item: GitIssueObject? {
		didSet {
			guard let item = item as? Milestone else { return }
			titleLabel.text = item.title
			dueDateLabel.text = item.dueDate?.description
			dueDateLabel.textColor = .lightGray
		}
	}

	private func setupViews() {
		let separatorView = UIView()
		contentView.addSubview(separatorView)
		separatorView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			separatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			separatorView.heightAnchor.constraint(equalToConstant: 0)
		])
		
		contentView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			titleLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -20),
			titleLabel.bottomAnchor.constraint(equalTo: separatorView.topAnchor)
		])
		
		contentView.addSubview(dueDateLabel)
		dueDateLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			dueDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			dueDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			dueDateLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor)
		])
	}
}
