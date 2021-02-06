//
//  UIColorExtension.swift
//  Pizza-Factory
//
//  Created by Ngan Chak Lung on 6/2/2021.
//

import UIKit

extension UIColor {
    static func initOver(_ cgfRed: CGFloat, _ cgfGreen: CGFloat, _ cgfBlue: CGFloat, _ cgfAlpha: CGFloat) -> UIColor {
        assert(cgfRed >= 0.0 && cgfRed <= 255.0, "Invalid red component")
        assert(cgfGreen >= 0.0 && cgfGreen <= 255.0, "Invalid green component")
        assert(cgfBlue >= 0.0 && cgfBlue <= 255.0, "Invalid blue component")
        return UIColor(red: cgfRed / 255.0, green: cgfGreen / 255.0, blue: cgfBlue / 255.0, alpha: cgfAlpha)
    }
    
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
