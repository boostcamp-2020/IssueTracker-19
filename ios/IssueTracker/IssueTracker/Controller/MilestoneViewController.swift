//
//  MilestoneViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class MilestoneViewController: UIViewController, ListCollectionViewProtocol {

	var list = [Milestone]()
	var dataSource: DataSource?
	var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureHierarchy()
		configureDataSource()
		updateData()
		updateList()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

	func updateData() {
		list = [
			Milestone(no: 1, title: "스프린트2", totalTasks: 36, closedTasks: 23, isClosed: false, isDeleted: false, dueDate: Date(), description: "이번 배포를 위한 스프린트"),
			Milestone(no: 2, title: "스프린트3", totalTasks: 0, closedTasks: 0, isClosed: false, isDeleted: false, dueDate: Date(), description: "다음 배포를 위한 스프린트")
		]
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let text = sender as? String,
		   text == "edit",
		   let editVC = segue.destination as? MilestoneEditViewController,
		   let indexPath = collectionView.indexPathsForSelectedItems?.first {
			editVC.milestone = list[indexPath.row]
		}
	}
}

extension MilestoneViewController {
	func configureHierarchy() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
		collectionView.delegate = self
		collectionView.backgroundColor = .clear
		collectionView.register(UINib(nibName: "MilestoneViewCell", bundle: nil),
								forCellWithReuseIdentifier: MilestoneViewCell.identifier)
		
		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
		])
	}
	
	func configureDataSource() {
		dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
			guard let cell = collectionView
					.dequeueReusableCell(withReuseIdentifier: MilestoneViewCell.identifier,
										 for: indexPath) as? MilestoneViewCell
			else { return nil }
		
			cell.milestone = item
			return cell
		}
		updateList()
	}
	
	func createLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (_, layoutEnvironment) -> NSCollectionLayoutSection? in
			var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
			configuration.backgroundColor = .systemGroupedBackground
			
			let section = NSCollectionLayoutSection.list(
				using: configuration,
				layoutEnvironment: layoutEnvironment
			)
			
			return section
		}
		return layout
	}
	
}

extension MilestoneViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		performSegue(withIdentifier: "milestoneEditSegue", sender: "edit")
	}
}
