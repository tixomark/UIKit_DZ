// NSLayoutConstraint+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширене для удобной работы с констрейнтами
extension NSLayoutConstraint {
    /// Активирует текущую констрейнту
    func activate() {
        isActive = true
    }

    /// Модифицирует текущую констрейнту указанным приоритетом
    /// - Parameter priority: Приоритет который нужно применить к констрейнте
    /// - Returns: Текущая констрейнта с новым приоритетом
    func priority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

    /// Модифицирует текущую констрейнту указанным приоритетом
    /// - Parameter priority: Приоритет который нужно применить к констрейнте
    /// - Returns: Текущая констрейнта с новым приоритетом
    func priority(_ priority: Float) -> NSLayoutConstraint {
        self.priority = .init(rawValue: priority)
        return self
    }

    /// Более удобный инициализатор
    /// - Parameter : View для левой части ограничения.
    /// - Parameter attr: Атрибут View для левой части ограничения.
    /// - Parameter relatedBy: Взаимосвязь между левой частью ограничения и правой частью ограничения.
    /// - Parameter to: View для правой части ограничения.
    /// - Parameter attr: Атрибут View для правой части ограничения.
    /// - Parameter multiplier: Константа умножается на атрибут в правой части ограничения как часть получения
    /// измененного атрибута.
    /// - Parameter constant: Константа, добавленная к умноженному значению атрибута в правой части ограничения, дает
    /// окончательный измененный атрибут.
    convenience init(
        _ item1: Any,
        attr attr1: NSLayoutConstraint.Attribute,
        relatedBy: NSLayoutConstraint.Relation,
        to item2: Any? = nil,
        attr attr2: NSLayoutConstraint.Attribute = .notAnAttribute,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) {
        self.init(
            item: item1,
            attribute: attr1,
            relatedBy: relatedBy,
            toItem: item2,
            attribute: attr2,
            multiplier: multiplier,
            constant: constant
        )
    }
}
