//
//  IssueCollectionViewCell.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/27.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class IssueCollectionViewCell: UICollectionViewListCell {
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        return view
    }()
    
    let issueTitle: UILabel = {
        let label = UILabel()
        label.text = "레이블 목록 보기 구현"
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        label.numberOfLines = 1
        return label
    }()
    
    let issueDescription: UILabel = {
        let label = UILabel()
        label.text = "레이블 전체 목록을 볼 수 있어야한다 2줄까지 보입니다."
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        label.numberOfLines = 2
        label.textColor = UIColor.systemGray3
        return label
    }()
    
    let milestone: UILabel = {
        let label = UILabel()
        label.text = "스프린트2"
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor.systemGray3
        return label
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "feature"
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(inset: CGFloat) {
        setupBaseView(inset: inset)
        setupIssueTitle()
        setupIssueDescription()
        setupMilestone()
        setupLabel()
    }
    
    private func setupIssueTitle() {
        view.addSubview(issueTitle)
        issueTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            issueTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            issueTitle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            issueTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            issueTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupIssueDescription() {
        view.addSubview(issueDescription)
        issueDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            issueDescription.topAnchor.constraint(equalTo: issueTitle.bottomAnchor),
            issueDescription.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            issueDescription.leadingAnchor.constraint(equalTo: issueTitle.leadingAnchor),
            issueDescription.widthAnchor.constraint(equalTo: issueTitle.widthAnchor)
        ])
    }
    
    private func setupMilestone() {
        view.addSubview(milestone)
        milestone.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            milestone.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            milestone.heightAnchor.constraint(equalToConstant: milestone.intrinsicContentSize.height + 5),
            milestone.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            milestone.widthAnchor.constraint(equalToConstant: milestone.intrinsicContentSize.width + 20),
            milestone.leadingAnchor.constraint(greaterThanOrEqualTo: issueTitle.trailingAnchor, constant: 1)
        ])
        milestone.layer.borderWidth = 1
        milestone.layer.cornerRadius = 5
        milestone.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    private func setupLabel() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: milestone.bottomAnchor, constant: 3),
            label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height + 5),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width + 20)
        ])
        label.backgroundColor = .systemPink
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
    }
    
    func setupBaseView(inset: CGFloat) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: inset),
            separatorLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        view.backgroundColor = UIColor.systemBackground
    }
    
    func setupViewsIfNeeded() {
        contentView.backgroundColor = .systemBackground
    }
}
