//
//  CommentAddViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/11.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit
import Foundation

class CommentAddViewController: UIViewController {

	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var doneButton: UIBarButtonItem!
	
	var issueNo: Int!
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }
    

	@IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
		let actionSheet = UIAlertController(title: "Are you sure you wnat to cancel?",
											message: "Your changes will be discarded.",
											preferredStyle: .actionSheet)
		
		let discardAction = UIAlertAction(title: "Discard Changes", style: .destructive) { [weak self] _ in
			self?.dismiss(animated: true, completion: nil)
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		actionSheet.addAction(discardAction)
		actionSheet.addAction(cancelAction)
		
		self.present(actionSheet, animated: true, completion: nil)
	}
	
	@IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
		guard let content = textView.text,
			  textView.textColor != .placeholderText,
			  !content.isEmpty
		else { return }
		
		let data = try? JSONEncoder().encode(["issueNo": issueNo.description, "content": content])
		
		HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/comments/", method: .POST, body: data) { [weak self] (result) in
			switch result {
			case .success(_):
				NotificationCenter.default.post(name: .didCommentAdd, object: self)
			case .failure(let error):
				print(error)
			}
		}
	}
}

extension CommentAddViewController: UITextViewDelegate {
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.text == "Leave a comment" && textView.textColor == .placeholderText {
			textView.text = ""
			textView.textColor = .label
		}
	}
	
	func textViewDidChange(_ textView: UITextView) {
		doneButton.isEnabled = !textView.text.isEmpty
	}
	
}
