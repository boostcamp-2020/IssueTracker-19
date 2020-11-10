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
	typealias CellRegistration = UICollectionView.CellRegistration<SIELabelViewCell, GitIssueObject>
	
	
	var navItem = UINavigationItem()
	var navBar = UINavigationBar()
	
	lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
	lazy var dataSource: DataSource = createDataSource()
	var cellRegistration: CellRegistration!
	var currentSnapshot: Snapshot!
	let searchController = UISearchController(searchResultsController: nil)
	
	let bottomViewSection: BottomViewSection
	
	let topSpace = CGFloat(10)
	var height: CGFloat { view.frame.height }
	var searchMode = false
	
	var selected = [GitIssueObject]()
	var deSelected = [GitIssueObject]()
	var searched = [GitIssueObject]()
	
	init(bottomViewSection: BottomViewSection) {
		self.bottomViewSection = bottomViewSection
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
