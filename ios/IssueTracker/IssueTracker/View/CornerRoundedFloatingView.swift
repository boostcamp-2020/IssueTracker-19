//
//  CornerRoundedFloatingView.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

@IBDesignable
class CornerRoundedFloatingView: UIView {
	
	@IBInspectable var cornerRounding: CGFloat = 5 {
		didSet {
			layer.cornerRadius = cornerRounding
		}
	}
	
	@IBInspectable var shadowColor: UIColor = UIColor.lightGray {
		didSet {
			layer.shadowColor = shadowColor.cgColor
		}
	}
	@IBInspectable var shadowOpacity: Float = 0.5 {
		didSet {
			layer.shadowOpacity = shadowOpacity
		}
	}
	
	@IBInspectable var shadowOffsetX: CGFloat = 0 {
		didSet {
			layer.shadowOffset = CGSize(width: shadowOffsetX, height: shadowOffsetY)
		}
	}

	@IBInspectable var shadowOffsetY: CGFloat = 0 {
		didSet {
			layer.shadowOffset = CGSize(width: shadowOffsetX, height: shadowOffsetY)
		}
	}
	
	@IBInspectable var shadowRadius: CGFloat = 3 {
		didSet {
			layer.shadowRadius = shadowRadius
		}
	}
    
	override func prepareForInterfaceBuilder() {
		configure()
	}

	override func awakeFromNib() {
		configure()
	}
	
	func configure() {
		layer.cornerRadius = cornerRounding
		layer.shadowColor = shadowColor.cgColor
		layer.shadowOpacity = shadowOpacity
		layer.shadowOffset = CGSize(width: shadowOffsetX, height: shadowOffsetY)
		layer.shadowRadius = shadowRadius
	}
}
