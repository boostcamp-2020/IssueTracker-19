//
//  UIExtension.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/10/27.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func addBorder(_ arrEdge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arrEdge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
            default:
                break
            }
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}
