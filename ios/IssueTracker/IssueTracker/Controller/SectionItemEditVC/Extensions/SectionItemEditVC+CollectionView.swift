//
//  SectionItemEditVC+CollectionView.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/10.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

extension SectionItemEditViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		var shouldInsertItemInEmptySelected = false
		if searchMode {
			guard let idx = deSelected.firstIndex(where: { $0 == searched[indexPath.row] })
			else { return }
			
			let item = deSelected.remove(at: idx)
			searchMode.toggle()
			searchController.isActive = false
			applySnapshot()
			shouldInsertItemInEmptySelected = selected.isEmpty
			selected.append(item)
		} else if indexPath.section == 0 {
			let item = selected.remove(at: indexPath.row)
			applySnapshot()
			insertInOrder(item, in: &deSelected)
		} else if bottomViewSection == .milestone && !selected.isEmpty {
			let selectingItem = deSelected.remove(at: indexPath.row)
			let deselectingItem = selected.removeFirst()
			applySnapshot()
			shouldInsertItemInEmptySelected = true
			selected.append(selectingItem)
			insertInOrder(deselectingItem, in: &deSelected)
		} else {
			let item = deSelected.remove(at: indexPath.row)
			applySnapshot()
			shouldInsertItemInEmptySelected = selected.isEmpty
			selected.append(item)
		}
		applySnapshot(animatingDifferences: !shouldInsertItemInEmptySelected)
	}
	
	func insertInOrder(_ item: GitIssueObject, in array: inout [GitIssueObject]) {
		if let idx = array.firstIndex(where: { item.searchText < $0.searchText }) {
			array.insert(item, at: idx)
		} else {
			array.append(item)
		}
	}
}

extension SectionItemEditViewController {
	func configureCollectionView() {
		collectionView.delegate = self
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.keyboardDismissMode = .onDrag
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: navBar.safeAreaLayoutGuide.bottomAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
		])
	}
	
	func createDataSource() -> DataSource {
		return DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
			switch self?.bottomViewSection {
			case .assignee:
				return collectionView.dequeueConfiguredReusableCell(
					using: UICollectionView.CellRegistration<SIEAssigneeViewCell, GitIssueObject>{ cell, indexPath, item in
						let buttonImage: UIImage?
						if indexPath.section == 0 && self?.searchMode == false {
							let image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysOriginal)
							buttonImage = image?.withTintColor(.lightGray)
						} else {
							buttonImage = UIImage(systemName: "plus.circle")
						}
						cell.button.setImage(buttonImage, for: .normal)
						cell.item = item
					},
					for: indexPath,
					item: item)
			case .label:
				return collectionView.dequeueConfiguredReusableCell(
					using: UICollectionView.CellRegistration<SIELabelViewCell, GitIssueObject>{ cell, indexPath, item in
						let buttonImage: UIImage?
						if indexPath.section == 0 && self?.searchMode == false {
							let image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysOriginal)
							buttonImage = image?.withTintColor(.lightGray)
						} else {
							buttonImage = UIImage(systemName: "plus.circle")
						}
						cell.button.setImage(buttonImage, for: .normal)
						cell.item = item
					},
					for: indexPath,
					item: item)
			case .milestone:
				return collectionView.dequeueConfiguredReusableCell(
					using: UICollectionView.CellRegistration<SIEMilestoneViewCell, GitIssueObject>{ cell, indexPath, item in
						let buttonImage: UIImage?
						if indexPath.section == 0 && self?.searchMode == false {
							let image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysOriginal)
							buttonImage = image?.withTintColor(.lightGray)
						} else {
							buttonImage = UIImage(systemName: "plus.circle")
						}
						cell.button.setImage(buttonImage, for: .normal)
						cell.item = item
					},
					for: indexPath,
					item: item)
			case .none:
				return nil
			}
		}
	}

	func updateCell(cell: SIEViewCell, indexPath: IndexPath, item: GitIssueObject) {
		let buttonImage: UIImage?
		if indexPath.section == 0 && searchMode == false {
			let image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysOriginal)
			buttonImage = image?.withTintColor(.lightGray)
		} else {
			buttonImage = UIImage(systemName: "plus.circle")
		}
		cell.button.setImage(buttonImage, for: .normal)
		cell.item = item
	}
	
	
	func configureDataSource() {
		let headerRegistration = UICollectionView.SupplementaryRegistration
		<SIEHeaderView>(elementKind: "Header") { view, _, _ in
			view.label.text = "SELECTED"
		}

		let footerRegistration = UICollectionView.SupplementaryRegistration
		<SIEFooterView>(elementKind: "Footer") { [weak self] view, _, _ in
			guard let self = self else { return }

			let headerText: String
			switch self.bottomViewSection {
			case .assignee:
				headerText = "No one assigned"
			case .label:
				headerText = "No labels selected"
			case .milestone:
				headerText = "No milestone selected"
			}
			view.label.text = headerText
		}

		dataSource.supplementaryViewProvider = { [weak self] (view, kind, index) in
			if kind == UICollectionView.elementKindSectionHeader {
				return self?.collectionView.dequeueConfiguredReusableSupplementary(
					using: headerRegistration,
					for: index
				)
			} else {
				return self?.collectionView.dequeueConfiguredReusableSupplementary(
					using: footerRegistration,
					for: index
				)
			}
		}
		
		applySnapshot(animatingDifferences: true)
	}
	
	func applySnapshot(animatingDifferences: Bool = false) {
		DispatchQueue.main.async {
			var snapshot = Snapshot()
			snapshot.appendSections([.selected])
			snapshot.appendItems(self.selected)
			snapshot.appendSections([.deSelected])
			snapshot.appendItems(self.deSelected)
			self.dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
		}
	}
	
	func createLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { [weak self] index, layoutEnvironment in
			var configuration: UICollectionLayoutListConfiguration
			configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
			configuration.backgroundColor = .systemGroupedBackground
			if self?.searchMode != true && index == 0 {
				configuration.headerMode = .supplementary
				configuration.footerMode = self?.selected.isEmpty == true ? .supplementary : .none
			}
			
			let section = NSCollectionLayoutSection.list(
				using: configuration,
				layoutEnvironment: layoutEnvironment
			)

			return section
		}
		return layout
	}
}

