//
//  String+toUIColorPair.swift
//  IssueTracker
//
//  Created by 조기현 on 2020/11/07.
//  Copyright © 2020 남기범. All rights reserved.
//

import UIKit

extension String {
	func toUIColorPair() -> (UIColor, UIColor) {
		var cString = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

		if cString.hasPrefix("#") {
			cString.remove(at: cString.startIndex)
		}
		
		if cString.count != 6 {
			return (.black, .white)
		}
		
		var rgbValue: UInt64 = 0
		Scanner(string: cString).scanHexInt64(&rgbValue)
		
		let red = CGFloat((rgbValue & 0xFF0000) >> 16)
		let green = CGFloat((rgbValue & 0x00FF00) >> 8)
		let blue = CGFloat(rgbValue & 0x0000FF)
		
		return (UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1),
				((red * 0.299 + green * 0.587 + blue * 0.114 > 186) ? .black : .white))
	}
}
