//
//  UIViewExtension.swift
//  Pizza-Factory
//
//  Created by Ngan Chak Lung on 6/2/2021.
//

import UIKit

extension UIView {
    func setBorder(color borderColor: UIColor = .black, width borderWidth: CGFloat = 1.0) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
}
