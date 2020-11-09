//
//  SectionItemEditVC+SearchBar.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/09.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

// MARK: - UISearchResultsUpdating Delegate
extension SectionItemEditViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		
	}
	
//	func filteredList(for queryOrNil: String?) -> [] {
//		guard let query = queryOrNil, !query.isEmpty else {
//			return allList
//		}
//		return allList.filter { $0.title.lowercased().contains(query.lowercased()) }
//	}
	
	func configureSearchController() {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search"
		navItem.searchController = searchController
		navItem.hidesSearchBarWhenScrolling = true
		definesPresentationContext = true
	}
}
