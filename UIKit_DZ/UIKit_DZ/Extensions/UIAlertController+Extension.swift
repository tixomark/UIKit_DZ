// UIAlertController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIAlertController {
    /// Удобный иничиализатор с возможность опускать параметры
    convenience init(title: String, message: String? = nil, style: UIAlertController.Style = .alert) {
        self.init(title: title, message: message, preferredStyle: style)
    }
}
