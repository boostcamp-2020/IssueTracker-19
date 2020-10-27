//
//  IssueCollectionViewCell.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/27.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class IssueCollectionViewCell: UICollectionViewCell {
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
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(view)
        
        view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        view.backgroundColor = UIColor.systemBackground
        view.layer.addBorder([.top], color: UIColor.systemGray, width: 0.5)
        
        view.addSubview(issueTitle)
        issueTitle.frame = CGRect(x: 15, y: 10, width: frame.width * 0.6, height: 25)
        
        view.addSubview(issueDescription)
        issueDescription.frame = CGRect(x: 15, y: 35, width: frame.width * 0.6, height: 60)
        
        view.addSubview(milestone)
        milestone.frame = CGRect(x: frame.width - (milestone.intrinsicContentSize.width + 30),
                                 y: 10,
                                 width: milestone.intrinsicContentSize.width + 20,
                                 height: milestone.intrinsicContentSize.height + 5)
        milestone.layer.borderWidth = 1
        milestone.layer.cornerRadius = 5
        milestone.layer.borderColor = UIColor.systemGray3.cgColor

        view.addSubview(label)
        label.frame = CGRect(x: frame.width - (label.intrinsicContentSize.width + 30),
                             y: 35,
                             width: label.intrinsicContentSize.width + 20,
                             height: label.intrinsicContentSize.height + 5)
        label.backgroundColor = .systemPink
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
    }
}
