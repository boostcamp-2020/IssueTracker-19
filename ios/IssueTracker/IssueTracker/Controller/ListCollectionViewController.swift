//
//  ListCollectionViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/02.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class SectionItem: Hashable {
	let identifier = UUID()
	
	static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
		return lhs.identifier == rhs.identifier
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}
}

class ListCollectionViewController<T: SectionItem>: UIViewController {
	typealias DataSource = UICollectionViewDiffableDataSource<Section, T>
	typealias Snapshot = NSDiffableDataSourceSnapshot<Section, T>
	
	var list = [T]()
	var dataSource: DataSource?
	var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
	
	func configureHierarchy() {}
	
	func configureDataSource() {}
	
	func createLayout() -> UICollectionViewLayout {
		fatalError()
	}
	
	func updateList() {
		var snapshot = Snapshot()
		snapshot.appendSections([.main])
		snapshot.appendItems(list)
		dataSource?.apply(snapshot, animatingDifferences: false)
	}
}
