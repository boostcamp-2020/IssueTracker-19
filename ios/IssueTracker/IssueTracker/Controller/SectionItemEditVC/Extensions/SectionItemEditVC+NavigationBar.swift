//
//  SectionItemEditVC+NavigationBar.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/11.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

extension SectionItemEditViewController {
	func configureNavigationBar() {
		navBar.backgroundColor = .tertiarySystemBackground
		navBar.setItems([navItem], animated: false)
		navBar.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			navBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
			navBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
		])
		navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
													target: nil,
													action: #selector(cancelButtonAction))
		navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
													 target: nil,
													 action: #selector(doneButtonAction))
	}
	
	@objc func doneButtonAction() {
		remove(with: selected)
	}
	
	@objc func cancelButtonAction() {
		remove()
	}
}
