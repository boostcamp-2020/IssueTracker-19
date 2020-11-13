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
		if let text = searchController.searchBar.text, !text.isEmpty {
			searchMode = true
			var snapshot = Snapshot()
			snapshot.appendSections([.deSelected])
			searched = filteredList(for: text)
			snapshot.appendItems(searched)
			dataSource.apply(snapshot, animatingDifferences: false)
		} else {
			searchMode = false
			applySnapshot(animatingDifferences: false)
		}
	}
	
	func filteredList(for queryOrNil: String?) -> [GitIssueObject] {
		guard let query = queryOrNil, !query.isEmpty else { return deSelected }
		return deSelected.filter { $0.searchText.lowercased().contains(query.lowercased()) }
	}
	
	func configureSearchController() {
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search"
		navItem.searchController = searchController
		navItem.hidesSearchBarWhenScrolling = true
		definesPresentationContext = true
	}
}
