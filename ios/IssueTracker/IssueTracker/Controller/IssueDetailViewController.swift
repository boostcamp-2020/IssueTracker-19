//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/10/31.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit
import MarkdownView

struct IssueWrapper: Codable {
	let issue: Issue2
}

class MarkdownWrapper {
	let markdown = MarkdownView()
	var height: CGFloat?
}

class IssueDetailViewController: UIViewController, ListCollectionViewProtocol {
	
	var issue: Issue!
	var issueWrapper: IssueWrapper?
	var list: [Comment] = []
	var markdownWrapper: [MarkdownWrapper] = []
	var dataSource: DataSource?
	
	var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
	var bottomViewController: IssueDetailBottomViewController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureBottomView()
		loadDate()
		
		configureNotification()
		
		configureHierarchy()
		configureDataSource()
		
		updateList()
		collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 96, right: 0)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		bottomViewController?.remove()
	}
	
	func loadDate() {
		markdownWrapper.forEach{ tmp in
			DispatchQueue.main.async {
				tmp.markdown.removeFromSuperview()
			}
			
		}
		markdownWrapper = []
		HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/issues/\(issue.no)", method: .GET) { [weak self] (result) in
			guard let self = self else { return }
			switch result {
			case .success(let data):
				let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any?]
				self.issueWrapper = try? JSONDecoder().decode(IssueWrapper.self, from: data)
				if let comments = self.issueWrapper?.issue.comments {
					self.list = comments
					print(comments.count)
					
					DispatchQueue.main.async { [weak self] in
						guard let self = self else { return }
						comments.forEach { (comment) in
							let wrapper = MarkdownWrapper()

							var frame = CGRect()
							frame.origin = .zero
							frame.size = self.view.frame.size
							frame.size.width -= 40
							wrapper.markdown.frame = frame
							
							wrapper.markdown.isScrollEnabled = false
							wrapper.markdown.load(markdown: comment.content)
							self.markdownWrapper.append(wrapper)
							wrapper.markdown.onRendered = { [weak self] height in
								wrapper.height = height
								self?.updateList()
							}
							
						}
					}
					
				}
				if let milestone = self.issueWrapper?.issue.milestone {
					self.bottomViewController?.milestones = [milestone]
					self.bottomViewController?.applySnapshot()
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
		
		bottomVC.issue = issue
		bottomViewController = bottomVC
		guard let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.last else { return }
		window.addSubview(bottomVC.view)
		bottomVC.setupView(superView: window)
		window.rootViewController?.addChild(bottomVC)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let controller = segue.destination as? CommentAddViewController {
			if let comment = sender as? Comment {
				controller.commentNo = comment.no
				controller.comment = comment
			} else {
				controller.issueNo = issue.no
			}
		}
	}
	
	
	// MARK: - Tab bar item Actions
	@IBAction func backButton(_ sender: UIBarButtonItem) {
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func editButton(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Edit title", message: nil, preferredStyle: .alert)

		alert.addTextField { [weak self](textField) in
			textField.text = self?.issue.title ?? ""
		}

		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak alert] (_) in
			guard let textFields = alert?.textFields,
				  let textField = textFields.first,
				  let issue = self?.issue,
				  let new = textField.text,
				  issue.title != new
				  else { return }

			HTTPAgent.shared.sendRequest(
				from: "http://49.50.163.23:3000/api/issues/\(issue.no.description)/title",
				method: .PATCH,
				body: try? JSONEncoder().encode(["title": new])) { result in
				switch result {
				case .success(_):
					self?.issue.title = new
					self?.updateList()
				case .failure(_):
					break
				}
			}
				
		}))

		self.present(alert, animated: true, completion: nil)
	}
	
	deinit {
		print(#function)
	}
}

// MARK: - Collection View Configuration
extension IssueDetailViewController {
	func configureHierarchy() {
		collectionView.collectionViewLayout = createLayout()
		collectionView.backgroundColor = .systemBackground
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
		dataSource = DataSource(collectionView: collectionView) {[weak self] collectionView, indexPath, item in
			guard let cell = collectionView
					.dequeueReusableCell(withReuseIdentifier: IssueDetailCommentViewCell.identifier,
										 for: indexPath) as? IssueDetailCommentViewCell
			else { return nil }
			
			cell.issueComment = item
			
			if let count = self?.markdownWrapper.count, count > indexPath.item {
				cell.wrapper = self?.markdownWrapper[indexPath.item]
				
			}
			print(indexPath.item)
			print(self?.markdownWrapper.count)
			return cell
		}
		dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
			guard kind == UICollectionView.elementKindSectionHeader,
				  let headerView = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: IssueDetailHeaderReusableView.identifier,
					for: indexPath) as? IssueDetailHeaderReusableView
			else { return nil }
			
			headerView.issue = self?.issue
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

// MARK: - Notification
extension IssueDetailViewController {
	func configureNotification() {
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(didClickCommentButton),
			name: .didClickCommentButton,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(didCommentAdd),
			name: .didCommentAdd,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(shouldUpdateHeaderInBottomVC),
			name: .shouldUpdateHeaderInBottomVC,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(scrollUp),
			name: .shouldScrollUp,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(scrollDown),
			name: .shouldScrollDown,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(didClickCommentOptionButton),
			name: .didClickCommentOptionButton,
			object: nil
		)
	}
	
	@objc func didClickCommentOptionButton(_ notification: Notification) {
		guard let comment = notification.object as? Comment else { return }
		let actionSheet = UIAlertController(title: nil,
											message: nil,
											preferredStyle: .actionSheet)
		let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
			HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/comments/\(comment.no.description)",
										 method: .DELETE) { [weak self] result in
				guard let self = self else { return }
				switch result {
				case .success(_):
					guard let idx = self.list.firstIndex(where: { $0.no == comment.no }) else { return }
					self.list.remove(at: idx)
					print(1123)
					self.updateList()
					
				case .failure(let error):
					print(error)
					DispatchQueue.main.async {
						
						self.presentAlert(title: "삭제 불가", message: "다른 유저의 정보를 수정할 수 없습니다.")
					}
					
				}
			}
			
			
		}
		let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
			self?.performSegue(withIdentifier: "addCommentSegue", sender: comment)
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		actionSheet.addAction(deleteAction)
		actionSheet.addAction(editAction)
		actionSheet.addAction(cancelAction)
		
		self.present(actionSheet, animated: true, completion: nil)
	}
	
	
	
	@objc func didClickCommentButton() {
		performSegue(withIdentifier: "addCommentSegue", sender: nil)
	}
	
	@objc func didCommentAdd(_ notification: Notification) {
		if let controller = notification.object as? CommentAddViewController {
			DispatchQueue.main.async {
				controller.dismiss(animated: true, completion: nil)
			}
			self.loadDate()
			self.updateList(animatingDifferences: true)
		}
	}
	
	@objc func shouldUpdateHeaderInBottomVC() {
		updateList()
	}
	
	@objc func scrollDown() {
		guard let indexPath = collectionView.indexPathsForVisibleItems.sorted().first,
			  indexPath.row == 0 else { return }
		collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
	}
	
	@objc func scrollUp() {
		let indexPath = IndexPath(row: 0, section: 0)
		collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
		
	}
	
	
	func presentAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: "OK", style: .destructive)
		alert.addAction(defaultAction)
		present(alert, animated: false, completion: nil)
	}
}
