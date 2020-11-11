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
//        performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
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
            .publisher(for: .googleLoginSuccess)
            .sink { [weak self] notification in
                DispatchQueue.main.async {
                    self?.presentIssueList(statusCode: notification.userInfo?["statusCode"] as? Int ?? 0)
                }
        }
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
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
    private func saveUserInKeychain(_ userIdentifier: String) {

    }
    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        DispatchQueue.main.async {
//            viewController.userIdentifierLabel.text = userIdentifier
//            if let givenName = fullName?.givenName {
//                viewController.givenNameLabel.text = givenName
//            }
//            if let familyName = fullName?.familyName {
//                viewController.familyNameLabel.text = familyName
//            }
//            if let email = email {
//                viewController.emailLabel.text = email
//            }
            self.performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
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
