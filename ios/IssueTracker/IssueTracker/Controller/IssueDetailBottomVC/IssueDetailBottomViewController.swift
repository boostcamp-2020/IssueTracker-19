//
//  IssueDetailBottomViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class IssueDetailBottomViewController: UIViewController {
	typealias DataSource = UICollectionViewDiffableDataSource<SectionType, HashableObject>
	
	enum SectionType: Int, CaseIterable {
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
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		showViewWithAnimation()
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
		assignees = User.all
		labels = Label.all
		milestones = [Milestone.all[0]]
	}
	
	func showViewWithAnimation() {
		UIView.animate(withDuration: 1) { [weak self] in
			guard let controller = self else { return }
			controller.view.frame.origin.y = controller.minTop
		} completion: { [weak self] (_) in
			guard let controller = self else { return }
			controller.topConstraint?.constant = controller.minTop
		}
	}
	
	// MARK: - User Event Handler
	@IBAction func addCommentAction(_ sender: UIButton) {
		
	}
	
	@IBAction func upButtonAction(_ sender: UIButton) {
	}
	
	@IBAction func downButtonAction(_ sender: UIButton) {
	}
	
	func sectionHeaderEditButtonAction(idx: Int?) {
		guard let editSectionItemVC = storyboard?.instantiateViewController(identifier: "editSectionItemVC") as? SectionItemEditViewController else { return }
		
		addChild(editSectionItemVC)
		editSectionItemVC.view.frame = view.bounds
		view.addSubview(editSectionItemVC.view)
		editSectionItemVC.didMove(toParent: self)
		
		view.isUserInteractionEnabled = false
	}
	
	func closeButtonAction() {
		print("close issue")
	}
}

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
			guard let type = SectionType(rawValue: sectionIdx) else { return nil }
			return self?.createLayoutSection(type: type)
		}
	}
	
	func createLayoutSection(type: SectionType) -> NSCollectionLayoutSection {
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
			switch SectionType(rawValue: indexPath.section) {
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
				headerView.closure = self?.sectionHeaderEditButtonAction
				headerView.titleLabel.text = SectionType(rawValue: indexPath.section)?.text
				return headerView
			} else {
				guard let footerView = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: BottomViewFooterView.identifier,
					for: indexPath) as? BottomViewFooterView
				else { return nil }
				footerView.closure = self?.closeButtonAction
				return footerView
			}
		}
		
		applySnapshot()
	}
	
	func applySnapshot() {
		var snapshot = NSDiffableDataSourceSnapshot<SectionType, HashableObject>()
		snapshot.appendSections([.assignee])
		snapshot.appendItems(assignees)
		snapshot.appendSections([.label])
		snapshot.appendItems(labels)
		snapshot.appendSections([.milestone])
		snapshot.appendItems(milestones)
		dataSource.apply(snapshot, animatingDifferences: false)
	}
	
}

// MARK: - Configure Bottom View's PanGesture
extension IssueDetailBottomViewController {
	func configureScrollAction() {
		let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
		view.addGestureRecognizer(gesture)
		
		NotificationCenter.default.addObserver(self,
											   selector: #selector(rotated),
											   name: UIDevice.orientationDidChangeNotification,
											   object: nil)
	}
	
	@objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
		let translation = recognizer.translation(in: view)
		let posY = view.frame.minY
		let nPosY = posY + translation.y
		print(posY)
		if nPosY < maxTop || minTop < nPosY { return }
		
		self.view.frame.origin.y = nPosY
		recognizer.setTranslation(.zero, in: view)
		
		let velocity = recognizer.velocity(in: view)
		if recognizer.state == .ended {
			UIView.animate(withDuration: 0.4) { [weak self] in
				guard let controller = self else { return }
				if velocity.y < -400 {
					controller.view.frame.origin.y = controller.maxTop
				} else if velocity.y > 400 {
					controller.view.frame.origin.y = controller.minTop
				} else {
					controller.view.frame.origin.y = nPosY < controller.screenHeight / 2 ?
						controller.maxTop : controller.minTop
				}
			} completion: { [weak self] _ in
				guard let controller = self else { return }
				controller.isBelow = controller.view.frame.origin.y == controller.minTop
				controller.topConstraint?.constant = controller.view.frame.origin.y
			}
		}
	}
	
	@objc func rotated() {
		topConstraint?.constant = isBelow ? minTop : maxTop
		heightConstraint?.constant = -maxTop
	}
}
