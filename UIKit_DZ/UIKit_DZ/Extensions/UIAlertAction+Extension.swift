// UIAlertAction+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIAlertAction {
    /// Удобный инициализатор для UIAlertAction в возможностью опускать параметры
    convenience init(
        title: String,
        style: UIAlertAction.Style = .default,
        completionHandler: ((UIAlertAction) -> Void)? = { _ in }
    ) {
        self.init(title: title, style: style, handler: completionHandler)
    }
}
