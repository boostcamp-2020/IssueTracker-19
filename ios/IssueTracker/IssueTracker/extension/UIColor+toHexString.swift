//
//  UIColor+toHexString.swift
//  IssueTracker
//
//  Created by 남기범 on 2020/11/10.
//  Copyright © 2020 남기범. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    convenience init(_ hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        
        if ((cString.count) != 6) {
            self.init("ff0000")
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }

    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }

        let rColor = Float(components[0])
        let gColor = Float(components[1])
        let bColor = Float(components[2])
        var aColor = Float(1.0)

        if components.count >= 4 {
            aColor = Float(components[3])
        }

        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(rColor * 255), lroundf(gColor * 255), lroundf(bColor * 255), lroundf(aColor * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(rColor * 255), lroundf(gColor * 255), lroundf(bColor * 255))
        }
    }

}
