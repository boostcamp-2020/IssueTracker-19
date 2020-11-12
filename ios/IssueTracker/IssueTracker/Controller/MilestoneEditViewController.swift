//
//  MilestoneEditViewController.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/04.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class MilestoneEditViewController: UIViewController {

	@IBOutlet weak var popupView: CornerRoundedFloatingView!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var descriptionTextField: UITextField!
	@IBOutlet weak var popupViewCenterYconstraint: NSLayoutConstraint!
	
	@IBOutlet weak var saveButton: UIButton!
	var milestone: Milestone?
	var constraintInEditMode: NSLayoutConstraint?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews(milestone)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShow),
			name: UIResponder.keyboardWillShowNotification,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillHide),
			name: UIResponder.keyboardWillHideNotification,
			object: nil
		)
    }
	
	func setupViews(_ milestone: Milestone?) {
		titleTextField.text = milestone?.title
		
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let date = dateFormatter.date(from: milestone?.dueDate ?? "")
		datePicker.setDate(date ?? Date(), animated: false)
		
		descriptionTextField.text = milestone?.description
		saveButton.isEnabled = false
		saveButton.setTitleColor(.systemGray, for: .normal)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		titleTextField.becomeFirstResponder()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
	
	@objc func keyboardWillShow(_ notification: NSNotification) {
		if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardRectangle = keyboardFrame.cgRectValue
			let keyboardHeight = keyboardRectangle.height
			
			constraintInEditMode?.isActive = false
			constraintInEditMode = view.safeAreaLayoutGuide.bottomAnchor.constraint(
				equalTo: popupView.bottomAnchor,
				constant: keyboardHeight + 20
			)
			popupViewCenterYconstraint.priority = .defaultLow
			constraintInEditMode?.isActive = true
		}
	}
	
	@objc func keyboardWillHide(_ notification: NSNotification) {
		constraintInEditMode?.isActive = false
		popupViewCenterYconstraint.priority = .required
	}
    
	@IBAction func closeButtonAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func resetButtonAction(_ sender: UIButton) {
		setupViews(milestone)
	}
	
	@IBAction func saveButtonAction(_ sender: UIButton) {
		guard let title = titleTextField.text, !title.isEmpty,
			  let dueDate = datePicker.toString() else { return }
		
		let data = try? JSONEncoder().encode([
			"title": title,
			"description": descriptionTextField.text,
			"dueDate": dueDate])
		
		let method: HTTPMethod
		var component = ""
		if let milestone = milestone{
			method = .PUT
			component.append("/\(milestone.no)")
		} else {
			method = .POST
		}
		
		HTTPAgent.shared.sendRequest(
			from: "http://49.50.163.23:3000/api/milestones\(component)",
			method: method,
			body: data
		) { [weak self] result in
			switch result {
			case .success(_):
				NotificationCenter.default.post(name: .shouldReloadDataInMilestoneVC, object: nil)
			case .failure(let error):
				print(error)
			}
			DispatchQueue.main.async {
				self?.dismiss(animated: true, completion: nil)
			}
		}
	}
	@IBAction func textFieldChanged(_ sender: UITextField) {
		
		if titleTextField.text?.isEmpty == true {
			saveButton.isEnabled = false
			saveButton.setTitleColor(.systemGray, for: .normal)
		} else if datePicker.toString() != milestone?.dueDate ||
					titleTextField.text != milestone?.title ||
					descriptionTextField.text != milestone?.description {
			saveButton.isEnabled = true
			saveButton.setTitleColor(.white, for: .normal)
		} else {
			saveButton.isEnabled = false
			saveButton.setTitleColor(.systemGray, for: .normal)
		}
	}
}

extension UIDatePicker {
	func toString() -> String? {
		let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
		guard let year = components.year,
			  let month = components.month,
			  let day = components.day else { return nil }
		
		return "\(year)-\(month)-\(day)"
	}
}
