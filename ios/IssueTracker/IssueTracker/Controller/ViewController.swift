//
//  ViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/26.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit
import Combine
import AuthenticationServices

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
        localChecker()
    }
    
    private func localChecker() {
        if let ID = UserDefaults.standard.value(forKey: "ID") as? String {
            guard let PW = UserDefaults
                    .standard.value(forKey: "PW") as? String else {
                return
            }
            
            loginChecker(ID: ID, PW: PW, auth: nil)
        }
    }
    
    private func loginChecker(ID: String, PW: String, auth: String?) {
        let data = try? JSONEncoder().encode(["id": ID,"pw": PW])
        HTTPAgent.shared.sendRequest(from: "http://49.50.163.23/api/auth/login", method: .POST, body: data) { [weak self] (result) in
            switch result {
            case .success(_):
                DispatchQueue.main
                    .async {
                        self?.performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
                    }
            case .failure(let error):
                print(error)
                DispatchQueue.main
                    .async {
                        self?.performSegue(withIdentifier: "JoinSegue", sender: ["id": ID, "pw": PW, "auth": auth!])
                    }
            }
        }
    }
    
    @IBAction func githubLogin(_ sender: UIButton) {
        HTTPAgent.shared.githubLoginAction()
    }
    
	@IBAction func appleLogin(_ sender: UIButton) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
	}
    
	@IBAction func loginButton(_ sender: Any) {
		let id = idTextField.text ?? ""
		let pw = pwdTextField.text ?? ""
		
		let data = try? JSONEncoder().encode(["id": id, "pw": pw])
		HTTPAgent.shared.sendRequest(from: "http://49.50.163.23/api/auth/login", method: .POST, body: data) { [weak self] (result) in
			DispatchQueue.main.async {
				switch result {
				case .success(_):
					UserDefaults.standard.setValue(id, forKey: "ID")
					UserDefaults.standard.setValue(pw, forKey: "PW")
					self?.performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
					
				case .failure(let error):
					self?.presentAlert(title: "로그인", message: "아이디와 비밀번호를 확인해 주세요.")
				}
			}
		}
	}
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(defaultAction)
        present(alert, animated: false, completion: nil)
    }
    
    func presentIssueList(statusCode: Int, id: String, pw: String) {
        /*
         서버 응답 결과로 처리
         */
        if statusCode == 200 {
            loginChecker(ID: id, PW: pw, auth: "GITHUB")
        } else {
            presentAlert(title: "실패", message: "구글 로그인에 실패했습니다.")
        }
    }
    
    func configureSubscriber() {
        // ["statusCode": statusCode, "id": id, "nickname": nickname, "pw": token]
        publisher = NotificationCenter.default
            .publisher(for: .googleLoginSuccess)
            .sink { [weak self] notification in
                DispatchQueue.main.async {
                    let statusCode = notification.userInfo?["statusCode"] as? Int ?? 0
                    let id = notification.userInfo?["id"] as? String ?? ""
                    let pw = notification.userInfo?["pw"] as? String ?? ""
                    self?.presentIssueList(statusCode: statusCode,
                                           id: id,
                                           pw: pw)
                }
        }
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let tokenString = String(data: appleIDCredential.identityToken!, encoding: .utf8)
            let userIdentifier = appleIDCredential.user
            
            self.showResultViewController(userIdentifier: userIdentifier, token: tokenString ?? "")
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }
        default:
            break
        }
    }
    private func showResultViewController(userIdentifier: String, token: String) {
        DispatchQueue.main.async {
            self.loginChecker(ID: userIdentifier, PW: token, auth: "APPLE")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let infoDic = sender as? [String: String] else {
            return
        }
        if let joinVC = segue.destination as? JoinViewController {
            joinVC.id = infoDic["id"] ?? ""
            joinVC.pw = infoDic["pw"] ?? ""
            joinVC.auth = infoDic["auth"] ?? ""
        }
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
