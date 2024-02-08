// ReverterModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Model for reverting strings
final class ReverterModel {
    // MARK: - Public Properties

    var reversedWord: String {
        var result = String(initialWord.reversed())
        if let firstLetter = initialWord.first, firstLetter.isUppercase {
            result = result.capitalized
        }
        return result
    }

    // MARK: - Private Properties

    private(set) var initialWord: String

    // MARK: - Life Cycle

    init(initialWord: String) {
        self.initialWord = initialWord
    }
}
