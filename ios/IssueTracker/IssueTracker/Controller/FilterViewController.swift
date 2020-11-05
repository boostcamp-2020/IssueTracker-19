//
//  FilterViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>! = nil
    private var collectionView: UICollectionView! = nil
    private var sectionTitles: [Item] = [
        Item(title: "다음 중에 조건을 고르세요"),
        Item(title: "세부 조건")
    ]
    private var lists: [[Item]] = [
        [
            Item(title: "열린 이슈들"),
            Item(title: "내가 작성한 이슈들"),
            Item(title: "나한테 할당된 이슈들"),
            Item(title: "내가 댓글을 남긴 이슈들"),
            Item(title: "닫힌 이슈들")
        ],
        [
            Item(title: "작성자"),
            Item(title: "레이블"),
            Item(title: "마일스톤"),
            Item(title: "담당자")
        ]
    ]
    
    private struct Item: Hashable {
        let title: String?
        private let identifier = UUID()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
//        dismiss(animated: true, completion: nil)
    }
}
extension FilterViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func configureDataSource() {
        let cellHeaderRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, _, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
            if indexPath.section == 1 {
                cell.accessories = [.disclosureIndicator()]
            } else {
                cell.accessories = []
            }
            cell.backgroundConfiguration?.backgroundColor = .systemBackground
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            if indexPath.item == 0 {
                return collectionView.dequeueConfiguredReusableCell(using: cellHeaderRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        }
        
        updateList()
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { _, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .grouped)
            config.headerMode = .firstItemInSection
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
    }
    
    private func updateList() {
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        let sections = Array(0..<2)
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        for section in sections {
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
            let headerItem = sectionTitles[section]
            sectionSnapshot.append([headerItem])
            let items = lists[section]
            sectionSnapshot.append(items, to: headerItem)
            sectionSnapshot.expand([headerItem])
            dataSource.apply(sectionSnapshot, to: section)
        }
    }
}
extension FilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewListCell else {
            return
        }
        
        if indexPath.section == 0 {
            cell.accessories = [.checkmark(displayed: .always, options: .init())]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewListCell else {
            return
        }
        
        if indexPath.section == 0 {
            cell.accessories = []
        }
    }
}
