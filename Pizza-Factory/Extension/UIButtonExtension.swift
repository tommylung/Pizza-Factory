//
//  UIButtonExtension.swift
//  Pizza-Factory
//
//  Created by Ngan Chak Lung on 6/2/2021.
//

import UIKit

extension UIButton {
    func setBorder(color borderColor: UIColor) {
        self.layer.borderColor = borderColor.cgColor
        self.setTitleColor(borderColor, for: .normal)
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
