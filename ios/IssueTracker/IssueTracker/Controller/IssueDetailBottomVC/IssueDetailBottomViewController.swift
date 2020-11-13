//
//  IssueDetailBottomViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

enum BottomViewSection: Int, CaseIterable {
	case assignee, label, milestone
	var text: String {
		switch self {
		case .assignee:
			return "Assignees"
		case .label:
			return "Labels"
		case .milestone:
			return "Milestone"
		}
	}
}

class IssueDetailBottomViewController: UIViewController {
	typealias DataSource = UICollectionViewDiffableDataSource<BottomViewSection, GitIssueObject>
	
	@IBOutlet weak var mainView: UIView!
	@IBOutlet weak var subView: UIView!
	
	@IBOutlet weak var commentButtonView: CornerRoundedFloatingView!
	@IBOutlet weak var collectionView: UICollectionView!
	var dataSource: DataSource!
	
	// MARK: Variables for determining view frame
	var statusBarHeight: CGFloat {
		let height: CGFloat
		if #available(iOS 13.0, *) {
			let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
			height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 20
		} else {
			height = UIApplication.shared.statusBarFrame.height
		}
		return height == 0 ? 20 : height
	}
	var screenHeight: CGFloat { UIScreen.main.bounds.height }
	var minTop: CGFloat { screenHeight - (commentButtonView.frame.maxY + 20) }
	var maxTop: CGFloat { statusBarHeight + 20 }
	var topConstraint: NSLayoutConstraint?
	var heightConstraint: NSLayoutConstraint?
	var isBelow = true
	var gestureRecognizer: UIPanGestureRecognizer?
	
	var issue: Issue!
	
//	var issueNo: Int!
//	var issueIsOpened: Bool!
	// MARK: Collection view's section items
	var assignees = [User]()
	var labels = [Label]()
	var milestones = [Milestone]()
	
	// MARK: - life cycle
	override func viewDidLoad() {
        super.viewDidLoad()
		loadData()
		configureScrollAction()
		configureHierarchy()
		configureDataSource()
		configureNotification()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		showViewWithAnimation()
	}
	
	func remove() {
		willMove(toParent: nil)
		view.removeFromSuperview()
		removeFromParent()
	}
	
	
	func setupView(superView: UIView) {
		view.translatesAutoresizingMaskIntoConstraints = false
		topConstraint = view.topAnchor.constraint(equalTo: superView.topAnchor, constant: screenHeight)
		heightConstraint = view.heightAnchor.constraint(equalTo: superView.heightAnchor, constant: -maxTop)
		NSLayoutConstraint.activate([
			view.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor),
			view.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor),
			topConstraint!,
			heightConstraint!
		])
	}
	
	func loadData() {
		assignees = issue.assignees
		labels = issue.labels
	}
	
	func showViewWithAnimation() {
		UIView.animate(withDuration: 0.5) { [weak self] in
			guard let controller = self else { return }
			controller.view.frame.origin.y = controller.minTop
		} completion: { [weak self] (_) in
			guard let controller = self else { return }
			controller.topConstraint?.constant = controller.minTop
		}
	}
	deinit {
		print(#function)
	}
}
