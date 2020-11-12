//
//  BottomViewFooterView.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/08.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class BottomViewFooterView: UICollectionReusableView {
	@IBOutlet weak var button: UIButton!
	static var identifier: String {
		Self.self.description()
	}
	
	var isOpened: Bool? {
		didSet {
			if isOpened == true {
				button.setTitle("Close Issue", for: .normal)
				button.setTitleColor(.systemRed, for: .normal)
			} else {
				button.setTitle("Open Issue", for: .normal)
				button.setTitleColor(.systemGreen, for: .normal)
			}
		}
	}
	
	@IBAction func openCloseButtonAction(_ sender: UIButton) {
		NotificationCenter.default.post(name: .didClickBottomViewOpenCloseIssueButton, object: isOpened)
	}
}
