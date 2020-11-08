//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/10/31.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class IssueComment: HashableObject {
	let author: String
	let content: String
	init(author: String, content: String) {
		self.author = author
		self.content = content
        super.init()
	}
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class IssueDetailViewController: UIViewController, ListCollectionViewProtocol {
	
	var issue: Issue!
	var list: [IssueComment] = []
	var dataSource: DataSource?
	
	var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
	var bottomViewController: IssueDetailBottomViewController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureHierarchy()
		configureDataSource()
		configureBottomView()
		updateList()
		
	}
	
	func configureBottomView() {
		guard let bottomVC = storyboard?.instantiateViewController(identifier: "issueDetailBottomVC")
				as? IssueDetailBottomViewController
		else { return }
		
		bottomViewController = bottomVC
		guard let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.last else { return }
		window.addSubview(bottomVC.view)
		bottomVC.setupView(superView: window)
		window.rootViewController?.addChild(bottomVC)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		// TODO: 서버 API 통신 구현 후 viewDidLoad로 이동
		updateIssueDetail()
//		bottomViewController?.showViewWithAnimation()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		bottomViewController?.view.removeFromSuperview()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 96, right: 0)
	}
	
	func updateIssueDetail() {
		list = [
			IssueComment(author: "godrm",
						 content: "레이블 전체 목록을 볼 수 있는게 어떨까요\n 전체 설명이 보여야 선택할 수 있으니까\n\n마크다운 문법을 지원하고 \n HTML형태로 보여줘야 할까요"),
			IssueComment(author: "crong",
						 content: "긍정적인 기능이네요\n 댓글은 두 줄"),
			IssueComment(author: "honux",
						 content: "안녕하세요 호눅스입니다")
		]
		updateList()
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
