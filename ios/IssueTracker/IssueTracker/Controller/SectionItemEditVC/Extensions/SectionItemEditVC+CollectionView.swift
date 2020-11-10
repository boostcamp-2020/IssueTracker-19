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
		if searchMode {
			guard let idx = deSelected.firstIndex(where: { $0 == searched[indexPath.row] })
			else { return }
			selected.append(deSelected.remove(at: idx))
			searchMode.toggle()
			searchController.isActive = false
		} else if indexPath.section == 0 {
			deSelected.insert(selected.remove(at: indexPath.row), at: 0)
		} else {
			selected.append(deSelected.remove(at: indexPath.row))
		}
		applySnapshot(animatingDifferences: true)
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
		return DataSource(collectionView: collectionView) {[weak self] collectionView, indexPath, item in
			guard let self = self else { return nil }
			let cell = collectionView
				.dequeueConfiguredReusableCell(using: self.cellRegistration,
											   for: indexPath,
											   item: item)
			return cell
		}
	}
	
	func configureDataSource() {
		cellRegistration = CellRegistration(handler: { (cell, indexPath, item) in
			let buttonImage: UIImage?
			if indexPath.section == 0 && self.searchMode == false {
				buttonImage = UIImage(systemName: "plus.circle")
				
			} else {
				let image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
				buttonImage = image?.withTintColor(.lightGray)
				
			}
			UIView.animate(withDuration: 0.5) {
				
				cell.button.setImage(buttonImage, for: .normal)
			}
		})
		
		
		let supplementaryRegistration = UICollectionView.SupplementaryRegistration
		<TitleSupplementaryView>(elementKind: "header") { supplementaryView, _, indexPath in
			supplementaryView.label.text = indexPath.section == 0 ? "SELECTED" : ""
		}
		
		dataSource.supplementaryViewProvider = { (view, kind, index) in
			return self.collectionView.dequeueConfiguredReusableSupplementary(
				using: supplementaryRegistration, for: index)
		}
		
		applySnapshot(animatingDifferences: true)
	}
	
	func applySnapshot(animatingDifferences: Bool = false) {
		var snapshot = Snapshot()
		snapshot.appendSections([.selected])
		snapshot.appendItems(selected)
		snapshot.appendSections([.deSelected])
		snapshot.appendItems(deSelected)
		dataSource.apply(snapshot, animatingDifferences: animatingDifferences) { [weak self] in
			if animatingDifferences {
				self?.dataSource.apply(snapshot, animatingDifferences: false)
			}
		}
	}
	
	func createLayout() -> UICollectionViewLayout {
		return UICollectionViewCompositionalLayout { [weak self] _, layoutEnvironment in
			var configuration: UICollectionLayoutListConfiguration
			
			if self?.searchMode == true {
				configuration = UICollectionLayoutListConfiguration(appearance: .plain)
				configuration.backgroundColor = .systemGroupedBackground
			} else {
				configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
				configuration.backgroundColor = .systemGroupedBackground
				configuration.headerMode = .supplementary
			}
			
			let section = NSCollectionLayoutSection.list(
				using: configuration,
				layoutEnvironment: layoutEnvironment
			)
			return section
		}
	}
}
