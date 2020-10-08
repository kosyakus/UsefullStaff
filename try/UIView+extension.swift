//
//  UIView+extension.swift
//  try
//
//  Created by Natali on 01.10.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import UIKit

//class GradientView: UIView {
//    
//    private lazy var pulse: CAGradientLayer = {
//        let l = CAGradientLayer()
//        l.type = .axial
//        l.colors = [UIColor.purple, UIColor.darkGray]
//        l.locations = [0, 1]
//        l.startPoint = CGPoint(x: 0.5, y: 0.5)
//        l.endPoint = CGPoint(x: 1, y: 1)
//        layer.addSublayer(l)
//        return l
//    }()
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        layer.insertSublayer(pulse, at: 0)
//        pulse.frame = self.bounds
//        //pulse.cornerRadius = bounds.width / 2.0
//    }
//
//}



class GradientLayer: CALayer {

    var center: CGPoint {
        return CGPoint(x: bounds.width/2, y: bounds.height/2)
    }

    var colors: [UIColor] = [UIColor.black, UIColor.lightGray] {
        didSet {
            setNeedsDisplay()
        }
    }

    var cgColors: [CGColor] {
        return colors.map({ (color) -> CGColor in
            return color.cgColor
        })
    }

    override init() {
        super.init()
        needsDisplayOnBoundsChange = true
    }

    required init(coder aDecoder: NSCoder) {
        super.init()
    }

    override func draw(in context: CGContext) {
        context.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else {
            return
        }
        context.drawLinearGradient(gradient, start: center, end: CGPoint(x: bounds.width, y: bounds.height/2), options: CGGradientDrawingOptions(rawValue: 0))
        context.drawLinearGradient(gradient, start: center, end: CGPoint(x: 0, y: bounds.height/2), options: CGGradientDrawingOptions(rawValue: 0))
    }

}



class GradientView: UIView {

    private let gradientLayer = GradientLayer()

    var colors: [UIColor] {
        get {
            return gradientLayer.colors
        }
        set {
            gradientLayer.colors = newValue
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if gradientLayer.superlayer == nil {
            layer.insertSublayer(gradientLayer, at: 0)
        }
        gradientLayer.frame = bounds
    }

}
