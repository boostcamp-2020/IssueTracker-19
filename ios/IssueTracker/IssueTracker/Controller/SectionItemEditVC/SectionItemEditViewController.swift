//
//  SectionItemEditViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/08.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit


protocol foo {
	associatedtype DataSource
	
	func createDataSource() -> DataSource
}

class SectionItemEditViewController: UIViewController, foo {
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
	let issueNo: Int
	
	let topSpace = CGFloat(10)
	var height: CGFloat { view.frame.height }
	var searchMode = false
	
	var original = [GitIssueObject]()
	var selected = [GitIssueObject]()
	var deSelected = [GitIssueObject]()
	var searched = [GitIssueObject]()
	
	init(bottomViewSection: BottomViewSection, issueNo: Int) {
		self.bottomViewSection = bottomViewSection
		self.issueNo = issueNo
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureContentView()
		configureScrollAction()

		configureCollectionView()
		configureDataSource()

		if bottomViewSection != .milestone {
			configureSearchController()
		}
		configureNavigationBar()
		loadData()
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
			fetch(component: "users")
		case .label:
			fetch(component: "labels")
		case .milestone:
			fetch(component: "milestones")
		}
	}
	
	func fetch(component: String) {
		selected = original
		
		HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/\(component)", method: .GET) { [weak self] (result) in
			guard let vc = self else { return }
			switch result {
			case .success(let data):
//				let sample = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
				var items: [GitIssueObject]?
				switch vc.bottomViewSection {
				case .assignee:
					items = try? JSONDecoder().decode(UserWrapper.self, from: data).users
				case .label:
					items = try? JSONDecoder().decode(LabelWrapper.self, from: data).labels
				case .milestone:
					items = try? JSONDecoder().decode(MilestoneWrapper.self, from: data).milestones
				}
				guard let elements = items else { return }
				
				vc.deSelected = elements.filter({ (first) -> Bool in
					!vc.selected.contains { (second) -> Bool in
						first.searchText == second.searchText
					}
				})
				vc.applySnapshot(animatingDifferences: true)
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func remove(_ isEdited: Bool = false) {
		NotificationCenter.default.post(name: .didIssueDetailEditFinish,
										object: bottomViewSection,
										userInfo: isEdited ?  ["selected": selected] : nil)
		willMove(toParent: nil)
		view.removeFromSuperview()
		removeFromParent()
	}

	deinit {
		print(#function)
	}
}


struct UserWrapper: Codable {
	let users: [User]
}

struct LabelWrapper: Codable {
	let labels: [Label]
}

struct MilestoneWrapper: Codable {
	let milestones: [Milestone]
}
