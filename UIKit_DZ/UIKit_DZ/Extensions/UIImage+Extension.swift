// UIImage+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImage {
    /// Перечисление содержащее названия изображений из Assets
    enum ImageNameFromProjectAssets: String {
        /// Кнопка запуска трека
        case play
        /// Кнопка состояния паузы
        case pause
        /// Картинка бегунка слайдера
        case sliderThumb
    }

    /// Удобная инициализация UIImage без использования строкового литерала
    convenience init?(_ name: ImageNameFromProjectAssets) {
        self.init(named: name.rawValue)
    }
}
