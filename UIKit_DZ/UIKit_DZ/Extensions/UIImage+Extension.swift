// UIImage+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImage {
    /// Перечисление содержащее названия изображений из Assets
    enum ImageNameFromProjectAssets: String {
        /// Иконка булавки локации
        case locationPinIcon
        /// Изображение завитушек (футер)
        case footer
        /// Изображение пирога
        case pie
        /// Изображение чашки
        case cup
        /// Изображение кофе
        case coffee
        /// Иконка креста
        case xIcon
    }

    /// Удобная инициализация UIImage без использования строкового литерала
    convenience init?(_ name: ImageNameFromProjectAssets) {
        self.init(named: name.rawValue)
    }
}
