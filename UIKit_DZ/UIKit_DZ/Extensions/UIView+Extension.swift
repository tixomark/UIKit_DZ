// UIView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение позволяющее добавлять несколько дочерних вью за раз
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

/// Расширение позволяющее переключать translatesAutoresizingMaskIntoConstraints сразу у нескольких view.
extension UIView {
    /// Устанавливает translatesAutoresizingMaskIntoConstraints в false для переданных вью
    static func doNotTranslateAoturesizingMaskIntoConstrains(for views: UIView...) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    /// Устанавливает translatesAutoresizingMaskIntoConstraints в false для массива переданных вью
    static func doNotTranslateAoturesizingMaskIntoConstrains(for views: [UIView]) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
