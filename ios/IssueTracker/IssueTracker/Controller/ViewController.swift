//
//  ViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/26.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit
import Combine

enum Notification {
    static let googleLoginSuccess = Foundation.Notification.Name("googleLoginSuccess")
}

class ViewController: UIViewController {
	@IBOutlet weak var idTextField: UITextField!
	@IBOutlet weak var pwdTextField: UITextField!
    var publisher: Cancellable?
	
	override func viewDidLoad() {
        super.viewDidLoad()
        configureSubscriber()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
//		if let token = UserDefaults.standard.value(forKey: "GoogleToken") as? String {
//            HTTPAgent.shared.getUser(token: token, completion: { [weak self] statuscode in
//                if statuscode == 200 {
//                    DispatchQueue.main.async {
//                        self?.performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
//                    }
//                } else {
//                    UserDefaults.standard.removeObject(forKey: "GoogleToken")
//                }
//            })
//        }
    }

    @IBAction func githubLogin(_ sender: UIButton) {
        HTTPAgent.shared.githubLoginAction()
    }
    
	@IBAction func appleLogin(_ sender: UIButton) {
		
	}
    
	@IBAction func loginButton(_ sender: Any) {
		if !(6...16).contains(idTextField.text?.count ?? 0)
			|| !(6...16).contains(pwdTextField.text?.count ?? 0) {
            presentAlert(title: "로그인", message: "아이디와 비밀번호의 길이가 적합하지 않습니다.")
		}
	}
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(defaultAction)
        present(alert, animated: false, completion: nil)
    }
    
    func presentIssueList(statusCode: Int) {
        if statusCode == 200 {
            performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
        } else {
            presentAlert(title: "실패", message: "구글 로그인에 실패했습니다.")
        }
    }
    
    func configureSubscriber() {
        publisher = NotificationCenter.default
            .publisher(for: Notification.googleLoginSuccess)
            .sink { [weak self] notification in
                DispatchQueue.main.async {
                    self?.presentIssueList(statusCode: notification.userInfo?["statusCode"] as? Int ?? 0)
                }
        }
    }
}
