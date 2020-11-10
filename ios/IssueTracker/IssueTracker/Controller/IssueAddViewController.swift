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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(markDown)
        markDown.frame = markdownTextView.frame
        markDown.isHidden = true
    }
    
    @IBAction func markdownChagedAction(_ sender: UISegmentedControl) {
        sender.selectedSegmentIndex == 0 ? transMarkdownTextView() : transMarkDownText()
    }
    
    func transMarkdownTextView() {
        markDown.isHidden = true
        markdownTextView.isHidden = false
    }
    
    func transMarkDownText() {
        markDown.isHidden = false
        markdownTextView.isHidden = true
        markDown.load(markdown: markdownTextView.text)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func issueAddButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
