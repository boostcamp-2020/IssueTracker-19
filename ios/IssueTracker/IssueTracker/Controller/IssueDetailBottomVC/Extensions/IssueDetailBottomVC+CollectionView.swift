//
//  IssueDetailBottomVC+CollectionView.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/09.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

// MARK: - Configure CollectionView and DataSource
extension IssueDetailBottomViewController {
	func configureHierarchy() {
		collectionView.collectionViewLayout = createLayout()
		
		collectionView.register(UINib(nibName: "BottomViewHeaderView", bundle: nil),
								forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
								withReuseIdentifier: BottomViewHeaderView.identifier)
		collectionView.register(UINib(nibName: "BottomViewAssigneeCell", bundle: nil),
								forCellWithReuseIdentifier: BottomViewAssigneeCell.identifier)
		collectionView.register(UINib(nibName: "BottomViewLabelCell", bundle: nil),
								forCellWithReuseIdentifier: BottomViewLabelCell.identifier)
		collectionView.register(UINib(nibName: "BottomViewMilestoneCell", bundle: nil),
								forCellWithReuseIdentifier: BottomViewMilestoneCell.identifier)
		collectionView.register(UINib(nibName: "BottomViewFooterView", bundle: nil),
								forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
								withReuseIdentifier: BottomViewFooterView.identifier)
	}
	
	func createLayout() -> UICollectionViewLayout {
		return UICollectionViewCompositionalLayout { [weak self] sectionIdx, _ in
			guard let type = BottomViewSection(rawValue: sectionIdx) else { return nil }
			return self?.createLayoutSection(type: type)
		}
	}
	
	func createLayoutSection(type: BottomViewSection) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(widthDimension: type == .label ? .estimated(44) : .fractionalWidth(1),
											  heightDimension: .estimated(44))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		group.interItemSpacing = .fixed(10)
		group.contentInsets.trailing = 20
		
		let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												heightDimension: .estimated(44))
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .top)
		
		let section = NSCollectionLayoutSection(group: group)
		section.interGroupSpacing = 5
		section.contentInsets.leading = 20
		section.boundarySupplementaryItems.append(sectionHeader)
		section.contentInsetsReference = .none
		
		if type == .milestone {
			let footer = NSCollectionLayoutBoundarySupplementaryItem(
				layoutSize: itemSize,
				elementKind: UICollectionView.elementKindSectionFooter,
				alignment: .bottom)
			section.boundarySupplementaryItems.append(footer)
		}
		
		return section
	}
	
	func createDataSource() -> DataSource {
		DataSource(collectionView: collectionView) { collectionView, indexPath, item in
			var identifier = ""
			switch BottomViewSection(rawValue: indexPath.section) {
			case .assignee:
				identifier = BottomViewAssigneeCell.identifier
			case .label:
				identifier = BottomViewLabelCell.identifier
			case .milestone:
				identifier = BottomViewMilestoneCell.identifier
			default:
				return nil
			}
			guard let cell = collectionView
					.dequeueReusableCell(withReuseIdentifier: identifier,
										 for: indexPath) as? SectionCell
			else { return nil }
			
			cell.item = item
			return cell
		}
	}
	
	func configureDataSource() {
		dataSource = createDataSource()
		
		dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
			if kind == UICollectionView.elementKindSectionHeader {
				guard let headerView = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: BottomViewHeaderView.identifier,
					for: indexPath) as? BottomViewHeaderView
				else { return nil }
				headerView.sectionIdx = indexPath.section
				headerView.titleLabel.text = BottomViewSection(rawValue: indexPath.section)?.text
				return headerView
			} else {
				guard let footerView = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: BottomViewFooterView.identifier,
					for: indexPath) as? BottomViewFooterView
				else { return nil }
				footerView.isOpened = self?.issue.isOpened == 1 ? true : false
				return footerView
			}
		}
		
		applySnapshot()
	}
	
	func applySnapshot() {
		var snapshot = NSDiffableDataSourceSnapshot<BottomViewSection, GitIssueObject>()
		snapshot.appendSections([.assignee])
		snapshot.appendItems(assignees)
		snapshot.appendSections([.label])
		snapshot.appendItems(labels)
		snapshot.appendSections([.milestone])
		snapshot.appendItems(milestones)
		DispatchQueue.main.async {
			self.dataSource.apply(snapshot, animatingDifferences: false)
		}
	}
	
}
