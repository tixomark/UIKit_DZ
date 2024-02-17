// Array+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для удобной активации массива констрейнт
extension Array where Element == NSLayoutConstraint {
    /// Активирует все констрейнты текущего массива
    func activate() {
        NSLayoutConstraint.activate(self)
    }
}
