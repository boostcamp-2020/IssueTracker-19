//
//  BottomViewFooterView.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/08.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class BottomViewFooterView: UICollectionReusableView {
	static var identifier: String {
		Self.self.description()
	}

	var closure: (() -> Void)?
	
	@IBAction func closeButtonAction(_ sender: UIButton) {
		closure?()
	}
}
