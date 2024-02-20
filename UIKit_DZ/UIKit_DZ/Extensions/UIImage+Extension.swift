// UIImage+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Удобная инициализация UIImage без использования строкового литерала
extension UIImage {
    convenience init?(_ name: AssetImageName) {
        self.init(named: name.rawValue)
    }
}
