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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		updateData()
        configureHierarchy()
        configureDataSource()
		addFloatingButton(view: view)
    }
    
    func updateData() {
        list = sample
    }
    
    @IBAction func issueEditButton(_ sender: UIBarButtonItem) {
        cellRegistration = Registration { (cell, _, _) in
            cell.setupViewsIfNeeded()
            cell.setupViews(inset: 30)
            cell.backgroundColor = .white
            cell.accessories = [
                .multiselect(displayed: .always, options: .init(isHidden: false, reservedLayoutWidth: .custom(5), tintColor: .systemGray6, backgroundColor: .blue))
            ]

            cell.layoutIfNeeded()
        }
        collectionView.allowsMultipleSelection = true
        updateList()
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
    func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
//        config.trailingSwipeActionsConfigurationProvider = { (indexPath) -> UISwipeActionsConfiguration in
//            return UISwipeActionsConfiguration(actions: [UIContextualAction(
//                                                    style: .destructive,
//                                                    title: "Delete",
//                                                    handler: { [weak self] _, _, completion in
//                                                        let sample = all[indexPath.item]
//                                                        all.removeAll { $0 == sample }
//                                                        self?.updateList()
//                                                        completion(true)
//                                                    })])
//        }
        
        config.backgroundColor = .systemGray5
        
        return UICollectionViewCompositionalLayout.list(using: config)
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
        
        collectionView.register(IssueCollectionViewCell.self, forCellWithReuseIdentifier: "IssueCell")
        collectionView.delegate = self
    }
    func configureDataSource() {
        
        cellRegistration = Registration { (cell, _, _) in
            cell.setupViewsIfNeeded()
            cell.setupViews(inset: 0)
            cell.backgroundConfiguration?.backgroundColor = .clear
        }
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: SampleIssue) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration!, for: indexPath, item: item)
        }
        
        updateList()
    }
}

extension IssueViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
    }
}
