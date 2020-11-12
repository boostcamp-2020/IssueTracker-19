//
//  FilterSelectViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/12.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

enum FilterDetailCase: String {
    case users, labels, milestones
}

class FilterSelectViewController: UIViewController {
    @IBOutlet weak var detailTitle: UILabel!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>! = nil
    private var collectionView: UICollectionView! = nil
    private var list = [Item]()
    
    var index = 1
    var filterCase: FilterDetailCase?
    var selectDelegate: FilterDetailSelectProtocol?
    
    private struct Item: Hashable {
        let title: String?
        private let identifier = UUID()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch index {
        case 1:
            filterCase = .users
        case 2:
            filterCase = .labels
        case 3:
            filterCase = .milestones
        case 4:
            filterCase = .users
        default:
            break
        }
        
        detailTitle.text = filterCase?.rawValue
        
        configureHierarchy()
        configureDataSource()
        loadData(filterCase: filterCase!)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
extension FilterSelectViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.detailTitle.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator()]

            cell.backgroundConfiguration?.backgroundColor = .systemBackground
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        updateList()
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { _, layoutEnvironment in
            let config = UICollectionLayoutListConfiguration(appearance: .plain)
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
    }
    
    private func updateList() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot, animatingDifferences: false)
        }
    }
}

extension FilterSelectViewController {
    func loadData(filterCase: FilterDetailCase) {
        HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/\(filterCase.rawValue)", method: .GET) { [weak self] (result) in
            switch result {
            case .success(let data):
                var items: [String]?
                switch filterCase {
                case .users:
					items = try? JSONDecoder().decode(UserWrapper.self, from: data).users.map { $0.nickname ?? $0.no.description }
                case .labels:
                    items = try? JSONDecoder().decode(LabelWrapper.self, from: data).labels.map { $0.name }
                case .milestones:
                    items = try? JSONDecoder().decode(MilestoneWrapper.self, from: data).milestones.map { $0.title }
                }
                guard let element = items else {
                    return
                }
                self?.list = element.map { Item(title: $0) }
                self?.updateList()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension FilterSelectViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectDelegate?.addSelectLabel(indexPath: IndexPath(item: index, section: 1),
                                       title: list[indexPath.item].title ?? "")
        dismiss(animated: true, completion: nil)
    }
}
