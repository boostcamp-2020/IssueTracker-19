//
//  SectionItemEditViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/08.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit


class SectionItemEditViewController: UIViewController {
	enum Section {
		case selected, deSelected
	}
	
	typealias DataSource = UICollectionViewDiffableDataSource<Section, GitIssueObject>
	typealias Snapshot = NSDiffableDataSourceSnapshot<Section, GitIssueObject>
	
	var navItem = UINavigationItem()
	var navBar = UINavigationBar()
	
	lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
	lazy var dataSource = createDataSource()

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
		
		if bottomViewSection != .milestone {
			configureSearchController()
		}
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
	
	
	
	func loadData() {
		switch bottomViewSection {
		case .assignee:
			selected = [User.all[0]]
			deSelected = User.all.suffix(User.all.count - 1)
		case .label:
			selected = [Label.all[0]]
			deSelected = Label.all.suffix(Label.all.count - 1)
		case .milestone:
			selected = [Milestone.all[0]]
			deSelected = Milestone.all.suffix(Milestone.all.count - 1)
		}
	}
	
	func remove(with data: [GitIssueObject]? = nil) {
		NotificationCenter.default.post(name: .didIssueDetailEditFinish, object: data)
		
		willMove(toParent: nil)
		view.removeFromSuperview()
		removeFromParent()
	}

}
