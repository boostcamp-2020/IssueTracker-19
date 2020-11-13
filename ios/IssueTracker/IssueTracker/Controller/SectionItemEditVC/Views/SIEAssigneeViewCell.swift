//
//  SIEAssigneeViewCell.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/11.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class SIEAssigneeViewCell: SIEViewCell {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	static let imageWidth = CGFloat(22)
	let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = imageWidth / 2
		imageView.clipsToBounds = true
		return imageView
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.lineBreakMode = .byTruncatingMiddle
		return label
	}()
	
	override var item: GitIssueObject? {
		didSet {
			guard let user = item as? User else { return }
			imageView.image = UIImage(systemName: "person")
			HTTPAgent.shared.loadImage(urlString: user.image ?? "") { [weak self] (result) in
				switch result {
				case .success(let path):
					DispatchQueue.main.async {
						self!.imageView.image = UIImage(contentsOfFile: path)
					}
				case .failure(let error):
					print(error)
				}
			}
			titleLabel.text = user.nickname
		}
	}

	private func setupViews() {
		contentView.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			imageView.widthAnchor.constraint(equalToConstant: SIEAssigneeViewCell.imageWidth),
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
		])
		
		contentView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -20)
		])
	}
}
