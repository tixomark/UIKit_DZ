// ReverterModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Model for reverting strings
final class ReverterModel {
    // MARK: - Public Properties

    var reversedWord: String? {
        guard let word else { return nil }
        var result = String(word.reversed())

        if let firstLetter = word.first, firstLetter.isUppercase {
            result = result.capitalized
        }

        return result
    }

    // MARK: - Private Properties

    private(set) var word: String?

    // MARK: - Life Cycle

    func updateWord(_ word: String?) {
        self.word = word
    }
}
