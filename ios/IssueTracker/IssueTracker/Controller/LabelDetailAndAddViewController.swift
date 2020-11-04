//
//  LabelDetailViewController.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/03.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

class LabelDetailAndAddViewController: UIViewController {
    @IBOutlet weak var colorPickerView: RoundView!
    @IBOutlet weak var colorPickerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var randomColorPickButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomColorPickButton.layer.cornerRadius = randomColorPickButton.frame.width/2.0-1
        colorPickerViewTopConstraint.constant = -100-colorPickerView.frame.height
        colorPickerView.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.colorPickerView.center = self.view.center
        })
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, animations: {
            self.colorPickerView.center.y = -100-self.colorPickerView.frame.height
        }, completion: { [weak self] done in
            if done {
                self?.dismiss(animated: false, completion: nil)
            }
        })
        
    }
}
