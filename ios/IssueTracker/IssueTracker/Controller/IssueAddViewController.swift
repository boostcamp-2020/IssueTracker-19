//
//  IssueAddViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit
import MarkdownView

class IssueAddViewController: UIViewController {
    @IBOutlet weak var issueNumber: UILabel!
    @IBOutlet weak var issueTitleTextField: UITextField!
    @IBOutlet weak var markdownToggle: UISegmentedControl!
    @IBOutlet weak var markdownTextView: UITextView!
    let markDown = MarkdownView()
    let picker = UIImagePickerController()
    var markDownImageStringArray = [String]()
    var markdownResult: String = ""
    var issueInsertDelegate: IssueInsertProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let menuItem = UIMenuItem(title: "Insert Photo", action: #selector(insertImageURL))
        UIMenuController.shared.menuItems = [menuItem]
        picker.delegate = self
        
        view.addSubview(markDown)
        markDown.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            markDown.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            markDown.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            markDown.topAnchor.constraint(equalTo: markdownToggle.bottomAnchor, constant: 10),
            markDown.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55)
        ])
        markDown.isHidden = true
        markdownTextView.delegate = self
    }
    
    @IBAction func markdownChagedAction(_ sender: UISegmentedControl) {
        sender.selectedSegmentIndex == 0 ? transMarkdownTextView() : transMarkDownText()
    }
    
    private func transMarkdownTextView() {
        markDown.isHidden = true
        markdownTextView.isHidden = false
    }
    
    private func transMarkDownText() {
        markDown.isHidden = false
        markdownTextView.isHidden = true
        
        markdownResult = markdownTextView.text
        for index in 0..<markDownImageStringArray.count {
            markdownResult = markdownResult.replacingOccurrences(of: "#image\(index)#",
                                                                  with: markDownImageStringArray[index])
        }
        markDown.load(markdown: markdownResult)
        /*
         markdownView load 메서드 수정
         pod 설치 후, load 메서드에 코드를 추가해줘야함.
         addSubview(wv) 이전에 아래의 코드를 추가할 것.
         
         for view in subviews where view.isKind(of: WKWebView.self) {
             view.removeFromSuperview()
         }
         */
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func issueAddButton(_ sender: UIButton) {
        guard let title = issueTitleTextField.text, title != "" else {
            presentAlert(title: "이슈 제목", message: "이슈 제목을 입력하지 않았어요!")
            return
        }
        markdownResult = markdownTextView.text
        for index in 0..<markDownImageStringArray.count {
            markdownResult = markdownResult.replacingOccurrences(of: "#image\(index)#",
                                                                  with: markDownImageStringArray[index])
        }
        issueInsertDelegate?.issueInsertAction(issueTitle: title, issueComment: markdownResult)
        dismiss(animated: true, completion: nil)
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(defaultAction)
        present(alert, animated: false, completion: nil)
    }
}

extension IssueAddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetupView()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if markdownTextView.text == "" {
            textViewSetupView()
        }
    }
    
    func textViewSetupView() {
        if markdownTextView.text == "코멘트는 여기다 작성하세요" {
            markdownTextView.text = ""
            markdownTextView.textColor = .label
        }
    }
}

extension IssueAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        let testString = image.jpegData(compressionQuality: 0.2)?.base64EncodedString()
        let logoString = "data:image/png;base64, \(testString!)"
        let resultString = "\n<img src=\"#image\(markDownImageStringArray.count)#\"></img>\n"
        
        markDownImageStringArray.append(logoString)
        markdownTextView.text.append(resultString)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func insertImageURL() {
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
}
