//
//  LabelDetailViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class LabelDetailAndAddViewController: UIViewController {
    private let alertView: UIView = {
        let alertView = UIView()
        alertView.backgroundColor = .white
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 12
        
        return alertView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.addSubview(alertView)
        alertView.frame = CGRect(x: 20, y: -300, width: self.view.frame.width-40, height: 300)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.width, height: 80))
        titleLabel.text = "hi, my name is KIBEOM"
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.center = self.view.center
        })
    }
}
