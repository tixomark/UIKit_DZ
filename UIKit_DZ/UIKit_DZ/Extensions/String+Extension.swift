// String+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для удобного создания NSMutableAttributedString из String
extension String {
    func attributed() -> NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }
}
