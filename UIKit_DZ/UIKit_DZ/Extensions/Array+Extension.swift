// Array+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension Array where Element == NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate(self)
    }
}
