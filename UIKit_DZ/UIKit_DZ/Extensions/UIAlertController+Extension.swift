// UIAlertController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIAlertController {
    /// Создает базовый алерт со слилем .alert
    convenience init(title: String, message: String? = nil) {
        self.init(title: title, message: message, preferredStyle: .alert)
    }
}
