// UIView + extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Emun of all images from assets
enum ImageName: String {
    case backgroundImage
}

extension UIImage {
    convenience init?(_ name: ImageName) {
        self.init(named: name.rawValue)
    }
}
