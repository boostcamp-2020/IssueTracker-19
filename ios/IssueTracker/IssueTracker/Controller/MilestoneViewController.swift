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
		updateList()
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(updateData),
			name: .shouldReloadDataInMilestoneVC,
			object: nil
		)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateData()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

	@objc func updateData() {
		HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/milestones", method: .GET) { [weak self] (result) in
			guard let vc = self else { return }
			switch result {
			case .success(let data):
				guard let data = try? JSONDecoder().decode(MilestoneWrapper.self, from: data).milestones else { return }
				vc.list = data
				vc.updateList()
			case .failure(let error):
				print(error)
			}
		}
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
		collectionView.backgroundColor = .systemBackground
		collectionView.delegate = self
		collectionView.register(UINib(nibName: "MilestoneViewCell", bundle: nil),
								forCellWithReuseIdentifier: MilestoneViewCell.identifier)
		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
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
