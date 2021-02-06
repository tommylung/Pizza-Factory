//
//  UIImageExtension.swift
//  Pizza-Factory
//
//  Created by Ngan Chak Lung on 6/2/2021.
//

import UIKit

extension UIImage {
    static func getGratusGradientImage(_ frame: CGRect, pStart: CGPoint = CGPoint(x: 0.0, y: 0.5), pEnd: CGPoint = CGPoint(x: 1.0, y: 0.5), cgfAlpha: CGFloat = 1.0) -> UIImage? {
        let gl = CALayer.getGratusGradientLayer(frame, pStart: pStart, pEnd: pEnd, cgfAlpha: cgfAlpha)
        UIGraphicsBeginImageContextWithOptions(gl.frame.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            gl.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
