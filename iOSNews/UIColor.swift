//
//  UIColor.swift
//  iOSNews
//
//  Created by 서종철 on 6/17/24.
//

import UIKit

/**
 * hex code로 색상을 표현
 */
extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
