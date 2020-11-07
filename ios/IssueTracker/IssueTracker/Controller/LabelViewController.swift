//
//  LabelViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController, ListCollectionViewProtocol {
    typealias Registration = UICollectionView.CellRegistration<LabelCollectionViewCell, Label>
    var list = [Label]()
    var dataSource: DataSource?
    var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: UICollectionViewLayout())
    var cellRegistration: Registration?
    
    struct Labels: Codable {
        var labels: [Label]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        updateData()
    }
    
    func updateData() {
        let data = try? JSONEncoder().encode(["id":"a","pw":"123"])
        
		HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/labels", method: .GET) { [weak self] (result) in
			switch result {
			case .success(let data):
				let sample = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
				let labels = try? JSONDecoder().decode(Labels.self, from: data)
				self?.list = labels!.labels
				self?.updateList()
			case .failure(let error):
				print(error)
			}
		}
//		
//        HTTPAgent.shared.sendRequest(from: "http://localhost:300/api/auth/login", method: .POST, body: data) { (result) in
//            switch result {
//            case .success(_):
//                HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/labels", method: .GET) { [weak self] (result) in
//                    switch result {
//                    case .success(let data):
//                        let sample = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
//                        let labels = try? JSONDecoder().decode(Labels.self, from: data)
//                        self?.list = labels!.labels
//                        self?.updateList()
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}
extension LabelViewController {
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
        
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.register(UINib(nibName: "LabelCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "LabelCollectionViewCell")
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Label>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: Label) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCollectionViewCell", for: indexPath) as? LabelCollectionViewCell else {
                return UICollectionViewCell()
            }
			cell.label = item
            
            NSLayoutConstraint.activate([
                cell.titleLabel.widthAnchor.constraint(equalToConstant: cell.titleLabel.intrinsicContentSize.width + 20)
            ])
            cell.labelHeightContraint.constant = cell.titleLabel.intrinsicContentSize.height + 5
            cell.titleLabel.layoutIfNeeded()
            cell.contentView.backgroundColor = .tertiarySystemBackground
            return cell
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
		config.backgroundColor = .systemGroupedBackground
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}
extension LabelViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "labelEditSegue", sender: nil)
    }
}
