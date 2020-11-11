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
		
		
		let itemsToAdd = selected.filter { (first) -> Bool in
			!original.contains { (second) -> Bool in
				first == second
			}
		}
		shouldItemAdd(itemsToAdd)
		
		let itemsToDelete = original.filter { (first) -> Bool in
			!selected.contains { (second) -> Bool in
				first == second
			}
		}
		
		if !(bottomViewSection == .milestone && !original.isEmpty && !selected.isEmpty) {
			itemsToDelete.forEach { shouldItemDelete($0.number) }			
		}
		
		
		remove(true)
	}
	
	func shouldItemDelete(_ number: Int) {
		let method: HTTPMethod
		let component: String
		var data: Data?
		switch bottomViewSection {
		case .assignee:
			method = .DELETE
			component = "assignees/\(number)"
		case .label:
			method = .DELETE
			component = "labels/\(number)"
		case .milestone:
			method = .PATCH
			component = "milestone"
			let null: Int? = nil
			data = try? JSONEncoder().encode(["milestoneNo": null])
		}
		
		HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/issues/\(issueNo)/\(component)", method: method, body: data)
		
	}
	
	func shouldItemAdd(_ items: [GitIssueObject]) {
		if items.isEmpty { return }
		let method: HTTPMethod
		let component: String
		let data: Data?
		switch bottomViewSection {
		case .assignee:
			method = .POST
			component = "assignees"
			data = try? JSONEncoder().encode(["assigneeNos": items.map { $0.number }])
		case .label:
			method = .POST
			component = "labels"
			data = try? JSONEncoder().encode(["labelNos": items.map { $0.number }])
		case .milestone:
			method = .PATCH
			component = "milestone"
			data = try? JSONEncoder().encode(["milestoneNo": items.first?.number])
		}
		
		HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/issues/\(issueNo)/\(component)", method: method, body: data)
			
		
		
	}
	
	
	@objc func cancelButtonAction() {
		remove()
	}
}
