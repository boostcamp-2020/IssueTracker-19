//
//  ViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/26.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var idTextField: UITextField!
	@IBOutlet weak var pwdTextField: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
		
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if let token = UserDefaults.standard.value(forKey: "GoogleToken") as? String {
			HTTPAgent.shared.getUser(token: token)
		}
	}


    @IBAction func githubLogin(_ sender: UIButton) {
        HTTPAgent.shared.githubLoginAction()
    }
    
	@IBAction func appleLogin(_ sender: UIButton) {
		
	}
	@IBAction func loginButton(_ sender: Any) {
		if !(6...16).contains(idTextField.text?.count ?? 0)
			|| !(6...16).contains(pwdTextField.text?.count ?? 0) {
			let alert = UIAlertController(title: "로그인", message: "아이디와 비밀번호의 길이가 적합하지 않습니다.", preferredStyle: .alert)
			let defaultAction = UIAlertAction(title: "OK", style: .destructive)
			alert.addAction(defaultAction)
			present(alert, animated: false, completion: nil)
		}
	}
}

