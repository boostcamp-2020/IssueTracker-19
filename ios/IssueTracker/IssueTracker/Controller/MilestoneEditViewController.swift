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
	@IBOutlet weak var dueDateTextField: UITextField!
	@IBOutlet weak var descriptionTextField: UITextField!
	@IBOutlet weak var popupViewCenterYconstraint: NSLayoutConstraint!
	
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
		dueDateTextField.text = milestone?.dueDate?.description
		descriptionTextField.text = milestone?.description
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
		print("save")
	}
}
