//
//  SectionItemEditViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/08.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

protocol SectionItemSelectViewDelegate {
	
}

class SectionItemEditViewController: UIViewController {
	enum Section {
		case selected, deSelected
	}
	
	typealias DataSource = UICollectionViewDiffableDataSource<Section, GitIssueObject>
	typealias Snapshot = NSDiffableDataSourceSnapshot<Section, GitIssueObject>
	
	
	var navItem = UINavigationItem()
	var navBar = UINavigationBar()
	
	lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
	lazy var dataSource: DataSource = createDataSource()
	var currentSnapshot: Snapshot! = nil
	
	let hashableObjectType: HashableObjectType
	
	let topSpace = CGFloat(10)
	var height: CGFloat { view.frame.height }
	
	
	var selected = [GitIssueObject]()
	var deSelected = [GitIssueObject]()
	
	init(hashableObjectType: HashableObjectType) {
		self.hashableObjectType = hashableObjectType
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		loadData()
		configureContentView()
		configureScrollAction()
		configureCollectionView()
		configureDataSource()
		configureSearchController()
		configureNavigationBar()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		view.frame.size.height = height + 10
		view.frame.origin.y = height
		UIView.animate(withDuration: 0.4) { [weak self] in
			guard let controller = self else { return }
			controller.view.frame.origin.y = controller.topSpace
		}
	}
	
	func configureContentView() {
		view.addSubview(navBar)
		view.addSubview(collectionView)
		view.backgroundColor = .systemGroupedBackground
	}
	
	func configureNavigationBar() {
		navBar.setItems([navItem], animated: false)
		navBar.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			navBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
			navBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
		])
	}
	
	func loadData() {
		selected = [Label.all[0]]
		deSelected = Label.all.suffix(Label.all.count - 1)
	}
	
	func remove() {
		willMove(toParent: nil)
		view.removeFromSuperview()
		removeFromParent()
	}

}


extension SectionItemEditViewController {
	func configureCollectionView() {
		collectionView.register(UINib(nibName: "MilestoneViewCell", bundle: nil),
								forCellWithReuseIdentifier: MilestoneViewCell.identifier)
		collectionView.delegate = self
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: navBar.safeAreaLayoutGuide.bottomAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
		])
		
		
	}
	
	func createDataSource() -> DataSource {
		return DataSource(collectionView: collectionView) { collectionView, indexPath, item in
			guard let cell = collectionView
					.dequeueReusableCell(withReuseIdentifier: MilestoneViewCell.identifier,
										 for: indexPath) as? MilestoneViewCell
			else { return nil }
		
			if let item = item as? Label {
				cell.titleLabel.text = item.color
			}
			return cell
		}
	}
	
	func configureDataSource() {
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
		dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
	}
	
	func createLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
			var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
			configuration.backgroundColor = .systemGroupedBackground
			configuration.headerMode = .supplementary
			
			let section = NSCollectionLayoutSection.list(
				using: configuration,
				layoutEnvironment: layoutEnvironment
			)
			
			if sectionIndex == 0 {
				let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
													   heightDimension: .estimated(44))
				let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
					layoutSize: titleSize,
					elementKind: "header",
					alignment: .top)
				section.boundarySupplementaryItems = [titleSupplementary]
			}
			return section
		}
		return layout
	}
}

extension SectionItemEditViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			deSelected.insert(selected.remove(at: indexPath.row), at: 0)
		} else {
			selected.append(deSelected.remove(at: indexPath.row))
		}
		applySnapshot(animatingDifferences: true)
	}
}

