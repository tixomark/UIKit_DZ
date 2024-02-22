// NSLayoutConstraints+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширени для короткого синтиксиса активации констрейнты
extension NSLayoutConstraint {
    /// Активация текущей констрейнты
    func activate() {
        isActive = true
    }
}
