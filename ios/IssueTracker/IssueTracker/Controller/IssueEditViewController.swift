//
//  IssueEditViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/29.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class IssueEditViewController: UIViewController, ListCollectionViewProtocol {
    var list = [SampleIssue]()
    var dataSource: DataSource?
    var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateData()
        configureHierarchy()
        configureDataSource()
        tabBarController?.tabBar.isHidden = true

        let toolBar = UIToolbar()
        view.addSubview(toolBar)
        toolBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            toolBar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            toolBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            toolBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let item = UIBarButtonItem(title: "선택 이슈 닫기", style: .plain, target: self, action: nil)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spacer, item], animated: true)
    }
    
    func updateData() {
        list = sample
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
}
extension IssueEditViewController {
    func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = .systemGray5
        
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}
extension IssueEditViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        collectionView.allowsMultipleSelection = true
    }
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<IssueCollectionViewCell, SampleIssue> { (cell, _, _) in
            cell.setupViewsIfNeeded()
            cell.setupViews(inset: 30)
            cell.accessories = [
                .multiselect(displayed: .always, options: .init(isHidden: false, reservedLayoutWidth: .custom(5), tintColor: .systemGray6, backgroundColor: .blue))
            ]
            cell.backgroundConfiguration?.backgroundColor = .systemBackground
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, SampleIssue>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: SampleIssue)
            -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        updateList()
    }
}

extension IssueEditViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
}
