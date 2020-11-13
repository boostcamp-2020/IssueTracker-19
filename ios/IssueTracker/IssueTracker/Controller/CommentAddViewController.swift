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
	
	var issueNo: Int?
	var commentNo: Int?
	var comment: Comment?
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let comment = comment {
			textView.text = comment.content
			textView.textColor = .label
			textView.becomeFirstResponder()
		}
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
		
		if let issueNo = issueNo {
			let data = try? JSONEncoder().encode(["issueNo": issueNo.description, "content": content])
			
			HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/comments/", method: .POST, body: data) { [weak self] (result) in
				switch result {
				case .success(_):
					NotificationCenter.default.post(name: .didCommentAdd, object: self)
				case .failure(let error):
					print(error)
				}
			}
		} else if let commentNo = commentNo {
			let data = try? JSONEncoder().encode(["content": content])
			print(commentNo)
			HTTPAgent.shared.sendRequest(from: "http://49.50.163.23:3000/api/comments/\(commentNo.description)", method: .PATCH, body: data) { [weak self] (result) in
				print("qwerwqer")
				
				switch result {
				case .success(_):
					NotificationCenter.default.post(name: .didCommentAdd, object: self)
				case .failure(let error):
					print(error)
					DispatchQueue.main.async {
						
						self?.presentAlert(title: "수정 불가", message: "다른 유저의 정보를 수정할 수 없습니다.")
						
					}
				}
			}
		}
		
		
	}
	func presentAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler: { [weak self](_) in
			self?.dismiss(animated: true, completion: nil)
		})
		
		alert.addAction(defaultAction)
		present(alert, animated: false, completion: nil)
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
		if let comment = comment {
			doneButton.isEnabled = doneButton.isEnabled && comment.content != textView.text
		}
	}
	
}
