//
//  CALayerExtension.swift
//  Pizza-Factory
//
//  Created by Ngan Chak Lung on 6/2/2021.
//

import UIKit

extension CALayer {
    static func getGratusGradientLayer(_ frame: CGRect, pStart: CGPoint = CGPoint(x: 0.0, y: 0.5), pEnd: CGPoint = CGPoint(x: 1.0, y: 0.5), cgfAlpha: CGFloat = 1.0) -> CAGradientLayer {
        let gl = CAGradientLayer()
        gl.frame = frame
        gl.colors = [UIColor.initOver(161.0, 76.0, 130.0, cgfAlpha).cgColor, UIColor.initOver(70.0, 22.0, 88.0, cgfAlpha).cgColor]
        gl.startPoint = pStart
        gl.endPoint = pEnd
        return gl
    }
}
