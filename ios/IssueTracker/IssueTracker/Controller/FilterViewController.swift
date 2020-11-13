//
//  FilterViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

struct SearchQuery {
    var isOpened: Int = -1
    var author: String = ""
    var assignee: String = ""
    var milestone: String = ""
    var comment: Int = -1
    var label: String = ""
}

protocol FilterDetailSelectProtocol {
    func addSelectLabel(indexPath: IndexPath, title: String)
}

class FilterViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>! = nil
    private var collectionView: UICollectionView! = nil
    private var query = SearchQuery()
    var filterDelegate: IssueFilterProtocol?
    
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
        filterDelegate?.issueFilterAddAction(query: query)
        dismiss(animated: true, completion: nil)
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

        if indexPath.section == 0, indexPath.item != 0 {
            guard let indexPaths = collectionView.indexPathsForSelectedItems else {
                cell.accessories = [.checkmark(displayed: .always, options: .init())]
                return
            }
            for selectIndexPath in indexPaths {
                let selectedCell = collectionView.cellForItem(at: selectIndexPath) as? UICollectionViewListCell
                selectedCell?.accessories = []
            }
            cell.accessories = [.checkmark(displayed: .always, options: .init())]
            
            switch indexPath.item {
            case 1:
                query.isOpened = 1
            case 2:
                query.author = "@me"
                cellLabelRemoveFromView(indexPath: IndexPath(item: 1, section: 1))
            case 3:
                query.assignee = "@me"
                cellLabelRemoveFromView(indexPath: IndexPath(item: 4, section: 1))
            case 4:
                query.comment = 1
            case 5:
                query.isOpened = 0
            default:
                return
            }
        } else if indexPath.section == 1, indexPath.item != 0 {
            switch indexPath.item {
            case 1:
                if query.author == "@me" {
                    presentAlert(title: "작성자", message: "작성자가 이미 자신으로 선택되어 있습니다.")
                    return
                }
            case 4:
                if query.assignee == "@me" {
                    presentAlert(title: "담당자", message: "담당자가 이미 자신으로 선택되어 있습니다.")
                    return
                }
            default:
                break
            }
            
            collectionView.deselectItem(at: indexPath, animated: false)
            performSegue(withIdentifier: "filterSelectSegue", sender: indexPath.item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewListCell else {
            return
        }
        
        if indexPath.section == 0 {
            cell.accessories = []
            
            switch indexPath.item {
            case 1:
                query.isOpened = -1
            case 2:
                query.author = ""
            case 3:
                query.assignee = ""
            case 4:
                query.comment = -1
            case 5:
                query.isOpened = -1
            default:
                return
            }
        }
    }
    
    func cellLabelRemoveFromView(indexPath: IndexPath) {
        guard let section1Cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        for view in section1Cell.contentView.subviews where view.isKind(of: UILabel.self) {
            guard let label = view as? UILabel else {
                return
            }
            if label.text!.contains("선택 : ") {
                label.removeFromSuperview()
            }
        }
    }
    
    func cellRemoveAccessory(indexPath: IndexPath) {
        guard let section1Cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewListCell else {
            return
        }
        section1Cell.accessories = []
    }
}

extension FilterViewController: FilterDetailSelectProtocol {
    func addSelectLabel(indexPath: IndexPath, title: String) {
        let sampleLabel = UILabel()
        sampleLabel.text = "선택 : \(title)"
        sampleLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
        sampleLabel.numberOfLines = 1
        sampleLabel.textAlignment = .center
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        for view in cell.contentView.subviews where view.isKind(of: UILabel.self) {
            guard let label = view as? UILabel else {
                return
            }
            if label.text!.contains("선택 : ") {
                label.removeFromSuperview()
            }
        }
        
        updateQuery(indexPath: indexPath, title: title)
        
        if indexPath.item == 1 {
            cellRemoveAccessory(indexPath: IndexPath(item: 2, section: 0))
        }
        if indexPath.item == 4 {
            cellRemoveAccessory(indexPath: IndexPath(item: 3, section: 0))
        }
        
        cell.contentView.addSubview(sampleLabel)
        sampleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sampleLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            sampleLabel.trailingAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            sampleLabel.widthAnchor.constraint(equalToConstant: sampleLabel.intrinsicContentSize.width),
            sampleLabel.heightAnchor.constraint(equalToConstant: sampleLabel.intrinsicContentSize.height)
        ])
        
        print(query)
    }
    
    func updateQuery(indexPath: IndexPath, title: String) {
        switch indexPath.item {
        case 1:
            query.author = title
        case 2:
            query.label = title
        case 3:
            query.milestone = title
        case 4:
            query.assignee = title
        default:
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectVC = segue.destination as? FilterSelectViewController {
            selectVC.index = sender as? Int ?? 0
            selectVC.selectDelegate = self
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(defaultAction)
        present(alert, animated: false, completion: nil)
    }
}
