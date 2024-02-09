// UIImage+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImage {
    /// Содержит названия изображений из Assets
    enum AssetsImages: String {
        /// Иконка закрытого глаза
        case hidenIcon
        /// Иконка открытого глаза
        case shownIcon
    }

    /// Иниуиализирует изображение из Assets
    convenience init?(_ name: AssetsImages) {
        self.init(named: name.rawValue)
    }
}
