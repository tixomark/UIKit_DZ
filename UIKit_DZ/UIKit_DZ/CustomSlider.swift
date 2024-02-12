// CustomSlider.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомный слайдер с высотой 8
class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = super.trackRect(forBounds: bounds)
        let customBounds = CGRect(
            origin: CGPoint(x: bounds.origin.x, y: bounds.origin.y),
            size: CGSize(width: bounds.size.width, height: 8)
        )
        return customBounds
    }
}
