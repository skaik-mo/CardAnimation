//  Skaik_mo
//
//  GradientView.swift
//  AlaAaynyApp
//
//  Created by Mohammed Skaik on 05/09/2022.
//

import Foundation
import UIKit

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical

    var startPoint: CGPoint {
        get { return points.startPoint }
    }

    var endPoint: CGPoint {
        get { return points.endPoint }
    }

    var points: GradientPoints {
        get {
            switch(self) {
            case .topRightBottomLeft:
                return (CGPoint.init(x: 0.0, y: 1.0), CGPoint.init(x: 1.0, y: 0.0))
            case .topLeftBottomRight:
                return (CGPoint.init(x: 0.0, y: 0.0), CGPoint.init(x: 1, y: 1))
            case .horizontal:
                return (CGPoint.init(x: 0.0, y: 0.5), CGPoint.init(x: 1.0, y: 0.5))
            case .vertical:
                return (CGPoint.init(x: 0.0, y: 0.0), CGPoint.init(x: 0.0, y: 1.0))
            }
        }
    }
}

class GradientView: UIStackView {

    @IBInspectable var startColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var endColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var startPoint: CGPoint = .zero {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var endPoint: CGPoint = .zero {
        didSet {
            setNeedsLayout()
        }
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
//        gradientLayer.locations = [0.01, 0.75]
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }

}
