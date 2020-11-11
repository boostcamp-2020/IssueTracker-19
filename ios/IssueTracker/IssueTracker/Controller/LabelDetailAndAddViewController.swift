//
//  LabelDetailViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class LabelDetailAndAddViewController: UIViewController {
    @IBOutlet weak var popupView: CornerRoundedFloatingView!
    @IBOutlet weak var labelTitleTextField: UITextField!
    @IBOutlet weak var labelDescriptionTextField: UITextField!
    @IBOutlet weak var labelColorCode: UIButton!
    @IBOutlet weak var colorView: RoundView!
    @IBOutlet weak var popupViewCenterYConstraint: NSLayoutConstraint!
    var constraintInEditMode: NSLayoutConstraint?
    var insertDelegate: LabelInsertOrEditProtocol?
    
    var labelName = ""
    var labelDescription = ""
    var labelColor = "#333333"
    var labelEditIndex: Int?
    var labelNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        labelEditSetting(colorText: labelColor)
    }
    
    private func labelEditSetting(colorText: String) {
        labelTitleTextField.text = labelName
        labelDescriptionTextField.text = labelDescription
        
        if colorText != "" {
            labelColorCode.setTitle(colorText, for: .normal)
            colorView.backgroundColor = UIColor(colorText)
        }
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
            popupViewCenterYConstraint.priority = .defaultLow
            constraintInEditMode?.isActive = true
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        constraintInEditMode?.isActive = false
        popupViewCenterYConstraint.priority = .required
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        labelTitleTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func saveLabel(_ sender: UIButton) {
        /*
         서버에 레이블 추가 동작 필요
         */
        
        if labelTitleTextField.text == "" {
            presentAlert(title: "레이블 이름", message: "레이블 이름이 없어요!")
            return
        }
        
        if let labelEditIndex = labelEditIndex {
            insertDelegate?.labelEditAction(labelName: labelTitleTextField.text ?? "",
                                            labelDescription: labelDescriptionTextField.text ?? "",
                                            colorCode: labelColorCode.titleLabel?.text ?? "",
                                            index: labelEditIndex, number: labelNumber)
        } else {
            insertDelegate?.labelInsertAction(labelName: labelTitleTextField.text ?? "",
                                              labelDescription: labelDescriptionTextField.text ?? "",
                                              colorCode: labelColorCode.titleLabel?.text ?? "")
        }
        
        dismiss(animated: false, completion: nil)
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(defaultAction)
        present(alert, animated: false, completion: nil)
    }
    
    @IBAction func colorSelectAction(_ sender: UIButton) {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.selectedColor = colorView.backgroundColor ?? .label
        picker.supportsAlpha = false
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func randomColorPicker(_ sender: UIButton) {
        let colorCode = String(format: "#%02lX%02lX%02lX",
                               lroundf(Float.random(in: 0...256)),
                               lroundf(Float.random(in: 0...256)),
                               lroundf(Float.random(in: 0...256)))
        labelColorCode.setTitle(colorCode, for: .normal)
        labelColorCode.layoutIfNeeded()
        colorView.backgroundColor = UIColor(colorCode)
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        labelEditSetting(colorText: labelColor)
    }
}

extension LabelDetailAndAddViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        labelColorCode.setTitle(color.toHex() ?? "", for: .normal)
        colorView.backgroundColor = color
        dismiss(animated: true, completion: nil)
    }
}
