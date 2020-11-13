//
//  ColorPickerView.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/04.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

@IBDesignable
class RoundView: UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
