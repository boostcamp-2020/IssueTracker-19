//
//  IssueViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/27.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class IssueViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private enum Section: CaseIterable {
        case issue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(IssueCollectionViewCell.self, forCellWithReuseIdentifier: "IssueCell")
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.width, height: 100)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColor = UIColor.systemGray5
        
    }
}

extension IssueViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueCell",
                                                            for: indexPath) as? IssueCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
