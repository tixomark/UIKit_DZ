// UIView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение позволяюеще добавлять несколько дочерних вью за раз
extension UIView {
    /// Добавляет несколько сабвюь
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }

    /// Перегрузка предыдущего метода если вдруг все вью уже лежат в массиве
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }

    /// Наложить тень на вью
    func dropShadow(width: Int = 2, height: Int = 3) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.masksToBounds = false
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
}
