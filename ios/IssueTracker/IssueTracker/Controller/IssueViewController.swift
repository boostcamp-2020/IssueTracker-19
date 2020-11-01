//
//  IssueViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/27.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

enum Section: Hashable {
    case main
}

var all = ["1", "2", "3"]

class IssueViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>! = nil
    private var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
        configureHierarchy()
        configureDataSource()
		addFloatingButton(view: view)
    }
    
    @IBAction func issueEditButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "presentIssueEdit", sender: nil)
    }
    	
	func addFloatingButton(view: UIView) {
		let button = UIButton()
		view.addSubview(button)
		button.translatesAutoresizingMaskIntoConstraints = false
		let guide = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			button.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10),
			button.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -10),
			button.widthAnchor.constraint(equalToConstant: 50),
			button.heightAnchor.constraint(equalTo: button.widthAnchor)
		])
		button.layer.cornerRadius = 25
		button.backgroundColor = .systemBlue
		button.layer.shadowColor = UIColor.black.cgColor
		button.layer.shadowRadius = 12
		button.layer.shadowOpacity = 0.5
		button.layer.shadowOffset = CGSize(width: 0, height: 7)
		button.tintColor = .white
		button.setImage(UIImage(systemName: "plus"), for: .normal)
		button.addTarget(self, action: #selector(floatingButtonClickAction), for: .touchUpInside)
	}
	
	@objc func floatingButtonClickAction() {
		performSegue(withIdentifier: "newIssueSegue", sender: nil)
	}
}
extension IssueViewController {
    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.trailingSwipeActionsConfigurationProvider = { (indexPath) -> UISwipeActionsConfiguration in
            return UISwipeActionsConfiguration(actions: [UIContextualAction(
                                                    style: .destructive,
                                                    title: "Delete",
                                                    handler: { [weak self] _, _, completion in
                                                        let sample = all[indexPath.item]
                                                        all.removeAll { $0 == sample }
                                                        self?.updateList()
                                                        completion(true)
                                                    })])
        }
        
        config.backgroundColor = .systemGray5
        config.showsSeparators = true
        
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}
extension IssueViewController {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        collectionView.delegate = self
    }
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<IssueCollectionViewCell, String> { (cell, _, _) in
            cell.setupViewsIfNeeded()
            cell.setupViews(inset: 0)
            cell.backgroundConfiguration?.backgroundColor = .clear
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: String) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        updateList()
    }
    
    private func updateList() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let issueDetailVC = segue.destination as? IssueDetailViewController {
			issueDetailVC.issue = Issue(no: 11,
										title: "이슈 생성 기능",
										author: "godrm",
										assignees: [],
										labels: [],
										isOpened: true,
										createdAt: Date(),
										closedAt: nil,
										milestone: nil,
										commentCount: 2)
		}
	}
}

extension IssueViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		performSegue(withIdentifier: "issueDetailSegue", sender: nil)
	}
}
