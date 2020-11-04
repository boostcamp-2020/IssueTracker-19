//
//  BottomBorderView.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/04.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

@IBDesignable
class BottomBorderView: UIView {

	@IBInspectable
	var borderColor: UIColor = .clear {
		didSet {
			border.backgroundColor = borderColor
		}
	}
	
	override func prepareForInterfaceBuilder() {
		configure()
	}

	override func awakeFromNib() {
		configure()
	}
    
	let border = UIView()
	func configure() {
		addSubview(border)
		border.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			border.leadingAnchor.constraint(equalTo: leadingAnchor),
			border.trailingAnchor.constraint(equalTo: trailingAnchor),
			border.bottomAnchor.constraint(equalTo: bottomAnchor),
			border.heightAnchor.constraint(equalToConstant: 0.5)
		])
		border.backgroundColor = borderColor
		
		
	}

}
