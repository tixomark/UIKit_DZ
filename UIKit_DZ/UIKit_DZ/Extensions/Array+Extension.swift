//
//  NSLayoutConstaint+Extension.swift
//  UIKit_DZ
//
//  Created by Tixon Markin on 15.02.2024.
//

import UIKit

extension Array where Element == NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate(self)
    }
}
