// UIView + extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }

    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
