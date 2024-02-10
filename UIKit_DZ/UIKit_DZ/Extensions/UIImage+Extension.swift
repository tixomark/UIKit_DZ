// UIImage+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImage {
    /// Перечисление содержащее названия изображений из Assets
    enum ImageNameFromProjectAssets: String {
        /// Изображение календаря с тортом для экрана авторизации
        case signInMainImage
        /// Иконка закрытого глаза
        case closedEyeIcon
        /// Иконка открытого глаза
        case openedEyeIcon
    }

    /// Удобная инициализация UIImage без использования строкового литерала
    convenience init?(_ name: ImageNameFromProjectAssets) {
        self.init(named: name.rawValue)
    }
}
