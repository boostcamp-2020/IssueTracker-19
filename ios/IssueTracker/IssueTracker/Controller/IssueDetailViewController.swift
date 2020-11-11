//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/10/31.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

struct IssueWrapper: Codable {
	let issue: Issue2
}

class IssueDetailViewController: UIViewController, ListCollectionViewProtocol {
	
	var issue: Issue!
	var issueWrapper: IssueWrapper?
	var list: [Comment] = []
	var dataSource: DataSource?
	
	var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
	var bottomViewController: IssueDetailBottomViewController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print(issue)
		
		loadDate()
		
		configureHierarchy()
		configureDataSource()
		configureBottomView()
		updateList()
	}
	
	func loadDate() {
		HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/issues/\(issue.no)", method: .GET) { [weak self] (result) in
			switch result {
			case .success(let data):
//				let sample = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
				self?.issueWrapper = try? JSONDecoder().decode(IssueWrapper.self, from: data)
				if let comments = self?.issueWrapper?.issue.comments {
					self?.list = comments
					self?.updateList()
				}
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func configureBottomView() {
		guard let bottomVC = storyboard?.instantiateViewController(identifier: "issueDetailBottomVC")
				as? IssueDetailBottomViewController
		else { return }
		
		bottomVC.assignees = issue.assignees
		bottomVC.labels = issue.labels
		if let milestone = issueWrapper?.issue.milestone {
			bottomVC.milestones = [milestone]
		}
		
		bottomViewController = bottomVC
		guard let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.last else { return }
		window.addSubview(bottomVC.view)
		bottomVC.setupView(superView: window)
		window.rootViewController?.addChild(bottomVC)
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		bottomViewController?.view.removeFromSuperview()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 96, right: 0)
	}
	
	// MARK: - Tab bar item Actions
	@IBAction func backButton(_ sender: UIBarButtonItem) {
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func editButton(_ sender: UIBarButtonItem) {
		
	}
}

// MARK: - Collection View Configuration
extension IssueDetailViewController {
	func configureHierarchy() {
		collectionView.collectionViewLayout = createLayout()
		collectionView.register(UINib(nibName: "IssueDetailHeaderReusableView", bundle: nil),
								forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
								withReuseIdentifier: IssueDetailHeaderReusableView.identifier)
		collectionView.register(UINib(nibName: "IssueDetailCommentViewCell", bundle: nil),
								forCellWithReuseIdentifier: IssueDetailCommentViewCell.identifier)
		
		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
		])
	}
	
	func configureDataSource() {
		dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
			guard let cell = collectionView
					.dequeueReusableCell(withReuseIdentifier: IssueDetailCommentViewCell.identifier,
										 for: indexPath) as? IssueDetailCommentViewCell
			else { return nil }
			
			cell.issueComment = item
			return cell
		}
		dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
			guard kind == UICollectionView.elementKindSectionHeader,
				  let headerView = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: IssueDetailHeaderReusableView.identifier,
					for: indexPath) as? IssueDetailHeaderReusableView
			else { return nil }
			
			headerView.issue = self.issue
			return headerView
		}
	}
	
	func createLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (_, layoutEnvironment) -> NSCollectionLayoutSection? in
			var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
			configuration.backgroundColor = .systemGroupedBackground
			configuration.showsSeparators = false
			
			let section = NSCollectionLayoutSection.list(
				using: configuration,
				layoutEnvironment: layoutEnvironment
			)
			
			let headerSize = NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1.0),
				heightDimension: .estimated(1000)
			)
			let header = NSCollectionLayoutBoundarySupplementaryItem(
				layoutSize: headerSize,
				elementKind: UICollectionView.elementKindSectionHeader,
				alignment: .top
			)
			
			section.boundarySupplementaryItems = [header]
			section.contentInsets = NSDirectionalEdgeInsets(
				top: 20, leading: 0, bottom: 0, trailing: 0
			)
			section.interGroupSpacing = 20
			
			return section
		}
		return layout
	}
	
}
