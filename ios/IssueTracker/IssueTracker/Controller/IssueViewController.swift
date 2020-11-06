//
//  IssueViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/27.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class IssueViewController: UIViewController, ListCollectionViewProtocol{
    struct Issues: Decodable {
        var issues: [Issue]
    }
    
    typealias Registration = UICollectionView.CellRegistration<IssueCollectionViewCell, Issue>
    var list = [Issue]()
    var dataSource: DataSource?
    var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var cellRegistration: Registration?
    var isMultiselectMode: Bool = false
    var toolbar = UIToolbar()
    var toolbarBottomConstraint: NSLayoutConstraint?
    var collectionViewBottomConstraint: NSLayoutConstraint?
    var floatingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
		addFloatingButton(view: view)
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbarBottomConstraint = toolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: tabBarController!.tabBar.frame.height - toolbar.frame.height)
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toolbarBottomConstraint!
        ])
        
        updateData()
    }
    
    func updateDataUser() {
        let data = try? JSONEncoder().encode(["id":"a","pw":"123"])
        
        HTTPAgent.shared.sendRequest(from: "http://localhost:300/api/auth/login", method: .POST, body: data) { (result) in
            switch result {
            case .success(let data):
                HTTPAgent.shared.sendRequest(from: "http://localhost:300/api/issues", method: .GET) { [weak self] (result) in
                    switch result {
                    case .success(let data):
                        let sample = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                        print(sample)
                        let issue = try? JSONDecoder().decode(Issues.self, from: data)
                        self?.list = issue!.issues
                        self?.updateList()
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateData() {
        let data = try? JSONEncoder().encode(["id":"a","pw":"123"])
        
        HTTPAgent.shared.sendRequest(from: "http://localhost:300/api/auth/login", method: .POST, body: data) { (result) in
            switch result {
            case .success(let data):
                HTTPAgent.shared.sendRequest(from: "http://localhost:300/api/issues", method: .GET) { [weak self] (result) in
                    switch result {
                    case .success(let data):
                        let sample = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                        let issue = try? JSONDecoder().decode(Issues.self, from: data)
                        self?.list = issue!.issues
                        self?.updateList()
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
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
        
        config.backgroundColor = .systemBackground
        
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
            
            toolbarBottomConstraint?.constant = toolbar.frame.height-tabBarController!.tabBar.frame.height
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
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -tabBarController!.tabBar.frame.height),
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
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: Issue) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration!, for: indexPath, item: item)
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        createSwipeLayout()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let issueDetailVC = segue.destination as? IssueDetailViewController {
//			issueDetailVC.issue = Issue(no: 11,
//										title: "이슈 생성 기능",
//										author: "godrm",
//										assignees: [],
//										labels: [],
//										isOpened: true,
//										createdAt: Date(),
//										closedAt: nil,
//										milestone: nil,
//										commentCount: 2)
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
