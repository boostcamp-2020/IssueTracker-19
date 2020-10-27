//
//  ViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/26.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let token = UserDefaults.standard.value(forKey: "GoogleToken") as? String {
            HTTPAgent.shared.getUser(token: token)
        }
    }


    @IBAction func githubLogin(_ sender: UIButton) {
        HTTPAgent.shared.githubLoginAction()
    }
    
}

