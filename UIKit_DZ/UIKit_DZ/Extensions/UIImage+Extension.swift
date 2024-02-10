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
        /// Изовражение helena из Assets
        case helena
        /// Изовражение verona из Assets
        case verona
        /// Изовражение tom из Assets
        case tom
        /// Изовражение alex из Assets
        case alex
        /// Изображение торта 
        case cake
    }

    /// Удобная инициализация UIImage без использования строкового литерала
    convenience init?(_ name: ImageNameFromProjectAssets) {
        self.init(named: name.rawValue)
    }
}
