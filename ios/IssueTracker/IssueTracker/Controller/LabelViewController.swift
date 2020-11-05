//
//  LabelViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController, ListCollectionViewProtocol {
    typealias Registration = UICollectionView.CellRegistration<LabelCollectionViewCell, SampleIssue>
    var list = [SampleIssue]()
    var dataSource: DataSource?
    var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: UICollectionViewLayout())
    var cellRegistration: Registration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateData()
        configureHierarchy()
        configureDataSource()
    }
    
    func updateData() {
        list = sample
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
        dataSource = UICollectionViewDiffableDataSource<Section, SampleIssue>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, _: SampleIssue) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCollectionViewCell", for: indexPath) as? LabelCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.label.text = "feature"
            
            NSLayoutConstraint.activate([
                cell.label.heightAnchor.constraint(equalToConstant: cell.label.intrinsicContentSize.height + 5),
                cell.label.widthAnchor.constraint(equalToConstant: cell.label.intrinsicContentSize.width + 20)
            ])
            cell.contentView.backgroundColor = .systemBackground
            return cell
        }
        
        updateList()
    }
    
    func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = .systemGray5
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}
extension LabelViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "labelEditSegue", sender: nil)
    }
}
