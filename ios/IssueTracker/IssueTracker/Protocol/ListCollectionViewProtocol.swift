//
//  ListCollectionViewProtocol.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/02.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

enum Section: Hashable {
    case main
}

protocol ListCollectionViewProtocol {
	associatedtype Item: Hashable

	typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
	typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
	
	var list: [Item] { get set }
	var dataSource: DataSource? { get set }
	var collectionView: UICollectionView { get set }
	
	func configureHierarchy()
	func configureDataSource()
	func createLayout() -> UICollectionViewLayout
}

extension ListCollectionViewProtocol {
	func updateList(animatingDifferences: Bool = false) {
		var snapshot = Snapshot()
		snapshot.appendSections([.main])
		snapshot.appendItems(list)
        
        DispatchQueue.main.async {
            dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
        }
	}
}
