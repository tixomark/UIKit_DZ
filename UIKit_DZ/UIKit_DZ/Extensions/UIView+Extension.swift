// UIView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение позволяеще добавлять несколько дочерних вью за раз
extension UIView {
    /// Добавляет несколько сабвюь
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }

    /// Перегрузка предыдущего метода если вдруг все вью уже лежат в массиве
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
