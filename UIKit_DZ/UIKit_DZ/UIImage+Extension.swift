// UIImage+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImage {
    enum ImageNames: String {
        case hidenIcon
        case shownIcon
    }

    convenience init?(_ name: ImageNames) {
        self.init(named: name.rawValue)
    }
}
