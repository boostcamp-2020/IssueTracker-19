//
//  IssueCollectionViewCell.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/27.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class IssueCollectionViewCell: UICollectionViewListCell {
    var milestoneWidthConstraint: NSLayoutConstraint?
    var labelWidthContraint: NSLayoutConstraint?
    var isOpenedLabelWidthContraint: NSLayoutConstraint?
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
    
    let isOpenedLabel: UILabel = {
        let label = UILabel()
        label.text = "Opened"
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    var issue: Issue? {
        didSet {
            issueTitle.text = issue?.title
            issue?.comment != nil ? (issueDescription.text = issue?.comment?.content) : (issueDescription.text = "")
            milestone.text = issue?.milestoneTitle ?? ""
            milestone.isHidden = (milestone.text == "")
            label.text = issue?.labels.first?.name ?? ""
            let pair = (issue?.labels.first?.color ?? "#333333").toUIColorPair()
            label.backgroundColor = pair.0
            label.textColor = pair.1
            label.isHidden = (label.text == "")
            changeIsOpenedLabel(isOpenedLabel, component: (issue?.isOpened != 0) ? IssueOpen() : IssueClosed())
            
            isOpenedLabelWidthContraint?.constant = isOpenedLabel.intrinsicContentSize.width + 10
			milestoneWidthConstraint?.constant = milestone.intrinsicContentSize.width + 10
			labelWidthContraint?.constant = label.intrinsicContentSize.width + 10
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews(inset: 0)
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
        setupIsOpenedLabel()
    }
    
    private func setupIssueTitle() {
        contentView.addSubview(issueTitle)
        issueTitle.translatesAutoresizingMaskIntoConstraints = false
        let issueTitleWidthConstraint = issueTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6)
        issueTitleWidthConstraint.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([
            issueTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            issueTitle.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),
            issueTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            issueTitleWidthConstraint
        ])
    }
    
    private func setupIssueDescription() {
        contentView.addSubview(issueDescription)
        issueDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            issueDescription.topAnchor.constraint(equalTo: issueTitle.bottomAnchor),
            issueDescription.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            issueDescription.leadingAnchor.constraint(equalTo: issueTitle.leadingAnchor),
            issueDescription.widthAnchor.constraint(equalTo: issueTitle.widthAnchor)
        ])
    }
    
    private func setupMilestone() {
        contentView.addSubview(milestone)
        milestone.translatesAutoresizingMaskIntoConstraints = false
        milestoneWidthConstraint = milestone.widthAnchor.constraint(equalToConstant: milestone.intrinsicContentSize.width + 20)
        NSLayoutConstraint.activate([
            milestone.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            milestone.heightAnchor.constraint(equalToConstant: 23),
            milestone.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            milestoneWidthConstraint!,
            milestone.leadingAnchor.constraint(greaterThanOrEqualTo: issueTitle.trailingAnchor, constant: 1)
        ])
		milestone.textColor = .systemGray
		milestone.backgroundColor = .quaternarySystemFill
        milestone.layer.borderWidth = 1
        milestone.layer.cornerRadius = 5
        milestone.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setupLabel() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        labelWidthContraint = label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width + 20)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: milestone.bottomAnchor, constant: 3),
            label.heightAnchor.constraint(equalToConstant: 23),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            labelWidthContraint!
        ])
        label.backgroundColor = .systemPink
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
    }
    
    private func setupIsOpenedLabel() {
        contentView.addSubview(isOpenedLabel)
        isOpenedLabel.translatesAutoresizingMaskIntoConstraints = false
        isOpenedLabelWidthContraint = isOpenedLabel.widthAnchor.constraint(equalToConstant: isOpenedLabel.intrinsicContentSize.width + 20)
        NSLayoutConstraint.activate([
            isOpenedLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 3),
            isOpenedLabel.heightAnchor.constraint(equalToConstant: 23),
            isOpenedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            isOpenedLabelWidthContraint!
        ])
    }
    
    func changeIsOpenedLabel(_ label: UILabel, component: IssueStatusViewComponent) {
        label.layer.borderWidth = 1
        label.layer.borderColor = component.normalColor.cgColor
        label.layer.cornerRadius = 5

        let attachment = NSTextAttachment()
        attachment.image = component.icon?.withTintColor(component.darkColor)

        let fullString = NSMutableAttributedString(attachment: attachment)
        fullString.append(NSAttributedString(string: component.text))

        label.attributedText = fullString
        label.textColor = component.darkColor
        label.layer.backgroundColor = component.lightColor.cgColor
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupBaseView(inset: CGFloat) {
		contentView.backgroundColor = .tertiarySystemBackground
    }
    
    func setupViewsIfNeeded() {
        contentView.backgroundColor = .tertiarySystemBackground
    }
}
