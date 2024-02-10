// UIAlertAction+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIAlertAction {
    /// Возвращает стандартное действие отмены
    static var cancel: UIAlertAction {
        self.init(title: "Отмена", style: .default)
    }

    /// Возвращает стандартное действие подтверждения
    static var ok: UIAlertAction {
        self.init(title: "Ок", style: .default)
    }

    /// Возвращает стандартное действие отмены с обработчиком
    static func cancel(completionHandler: ((UIAlertAction) -> Void)? = { _ in }) -> UIAlertAction {
        self.init(title: "Отмена", style: .default, handler: completionHandler)
    }

    /// Возвращает стандартное действие подтверждения с обработчиком
    static func ok(completionHandler: ((UIAlertAction) -> Void)? = { _ in }) -> UIAlertAction {
        self.init(title: "Ок", style: .default, handler: completionHandler)
    }

    /// Создает UIAlertAction со стилем .default
    convenience init(title: String, handler: ((UIAlertAction) -> Void)?) {
        self.init(title: title, style: .default, handler: handler)
    }
}
