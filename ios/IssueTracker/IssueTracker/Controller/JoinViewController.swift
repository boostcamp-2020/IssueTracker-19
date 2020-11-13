//
//  JoinViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/11.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {
    @IBOutlet weak var nickNameTextField: UITextField!
    var id = ""
    var pw = ""
    var auth = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func joinButton(_ sender: UIButton) {
        nickNameTextField.text != "" ? joinAction() : presentAlert(title: "회원가입", message: "닉네임을 입력해주세요!")
    }
    
    func joinAction() {
        let data = try? JSONEncoder().encode(["id":id,
                                              "pw":pw,
                                              "auth": auth,
                                              "nickname": nickNameTextField.text ?? ""])
        
        HTTPAgent.shared.sendRequest(from: "http://49.50.163.23/api/auth/signup", method: .POST, body: data) { [weak self] (result) in
            switch result {
            case .success(_):
                UserDefaults.standard.setValue(self?.id, forKey: "ID")
                UserDefaults.standard.setValue(self?.pw, forKey: "PW")
                self?.loginChecker()
            case .failure(let error):
                print("여기냐?")
                print(error)
            }
        }
    }
    
    private func loginChecker() {
        let data = try? JSONEncoder().encode(["id": self.id,"pw": self.pw])
        HTTPAgent.shared.sendRequest(from: "http://49.50.163.23/api/auth/login", method: .POST, body: data) { [weak self] (result) in
            switch result {
            case .success(_):
                DispatchQueue.main
                    .async {
                        self?.performSegue(withIdentifier: "JoinSuccessSegue", sender: nil)
                    }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(defaultAction)
        present(alert, animated: false, completion: nil)
    }
}
