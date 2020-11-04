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

var sample = [
    SampleIssue(),
    SampleIssue(),
    SampleIssue()
]

class IssueViewController: UIViewController, ListCollectionViewProtocol {
    typealias Registration = UICollectionView.CellRegistration<IssueCollectionViewCell, SampleIssue>
    var list = [SampleIssue]()
    var dataSource: DataSource?
    var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var cellRegistration: Registration?
    var isMultiselectMode: Bool = false
    var toolbar = UIToolbar()
    var toolbarBottomConstraint: NSLayoutConstraint?
    var floatingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let add = UIBarButtonItem(title: "선택 이슈 닫기", style: .plain, target: self, action: nil)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [spacer, add]
        
		updateData()
        configureHierarchy()
        configureDataSource()
		addFloatingButton(view: view)
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbarBottomConstraint = toolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 83-toolbar.frame.height)
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toolbarBottomConstraint!
        ])
    }
    
    func updateData() {
        list = sample
    }
    
    @IBAction func filterButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "filterSegue", sender: nil)
    }
    	
	func addFloatingButton(view: UIView) {
		view.addSubview(floatingButton)
		floatingButton.translatesAutoresizingMaskIntoConstraints = false
		let guide = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			floatingButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10),
			floatingButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -10),
			floatingButton.widthAnchor.constraint(equalToConstant: 50),
			floatingButton.heightAnchor.constraint(equalTo: floatingButton.widthAnchor)
		])
		floatingButton.layer.cornerRadius = 25
		floatingButton.backgroundColor = .systemBlue
		floatingButton.layer.shadowColor = UIColor.black.cgColor
		floatingButton.layer.shadowRadius = 12
		floatingButton.layer.shadowOpacity = 0.5
		floatingButton.layer.shadowOffset = CGSize(width: 0, height: 7)
		floatingButton.tintColor = .white
		floatingButton.setImage(UIImage(systemName: "plus"), for: .normal)
		floatingButton.addTarget(self, action: #selector(floatingButtonClickAction), for: .touchUpInside)
	}
	
	@objc func floatingButtonClickAction() {
		performSegue(withIdentifier: "newIssueSegue", sender: nil)
	}
}
extension IssueViewController {
    func createSwipeLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.trailingSwipeActionsConfigurationProvider = { (indexPath) -> UISwipeActionsConfiguration in
            return UISwipeActionsConfiguration(actions: [UIContextualAction(
                                                    style: .destructive,
                                                    title: "Delete",
                                                    handler: { [weak self] _, _, completion in
                                                        let sample = self?.list[indexPath.item]
                                                        self?.list.removeAll { $0 == sample }
                                                        self?.updateList()
                                                        completion(true)
                                                    })])
        }
        
        config.backgroundColor = .systemGray5
        
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    func createNoneswipeLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = .systemGray5
        
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        collectionView.isEditing = editing
        collectionView.allowsSelectionDuringEditing = editing
        collectionView.allowsMultipleSelectionDuringEditing = editing
        floatingButton.isHidden = editing
        
        if editing {
            let add = UIBarButtonItem(title: "선택 이슈 닫기", style: .plain, target: self, action: nil)
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            toolbar.setItems([spacer, add], animated: false)
            tabBarController?.tabBar.isHidden = true
            
            toolbarBottomConstraint?.constant = toolbar.frame.height-83
            toolbar.layoutIfNeeded()
            toolbar.isHidden = false
        } else {
            tabBarController?.tabBar.isHidden = false
            toolbar.isHidden = true
        }
    }
}
extension IssueViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
    }
    func configureDataSource() {
        
        cellRegistration = Registration { (cell, _, _) in
            cell.setupViewsIfNeeded()
            cell.setupViews(inset: 0)
            cell.accessories = [.multiselect()]
            cell.backgroundConfiguration?.backgroundColor = .systemBackground
        }
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: SampleIssue) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration!, for: indexPath, item: item)
        }
        
        updateList()
    }
    
    func createLayout() -> UICollectionViewLayout {
        createSwipeLayout()
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
		if !isEditing {
			performSegue(withIdentifier: "issueDetailSegue", sender: nil)
		}
	}
}
