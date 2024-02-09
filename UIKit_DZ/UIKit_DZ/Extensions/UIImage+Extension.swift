// UIImage+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для удобной инициализации UIImage
extension UIImage {
    /// Перечисление содержащее названия изображений из Assets
    enum ImageNameFromProjectAssets: String {
        case backgroundImage
    }

    convenience init?(_ name: ImageNameFromProjectAssets) {
        self.init(named: name.rawValue)
    }
}
