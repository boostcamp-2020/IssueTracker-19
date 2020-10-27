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
		
		addFloatingButton(view: view)
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

extension IssueViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueCell",
                                                            for: indexPath) as? IssueCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
