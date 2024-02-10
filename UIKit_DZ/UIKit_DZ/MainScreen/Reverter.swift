// Reverter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель для разворота слов в обратном направлении
final class Reverter {
    // MARK: - Public Properties

    /// Развурнутое слово
    var reversedWord: String? {
        guard let initialWord else { return nil }
        var result = String(initialWord.reversed())
        if let firstLetter = initialWord.first, firstLetter.isUppercase {
            result = result.capitalized
        }
        return result
    }

    // MARK: - Private Properties

    /// Изначальное слово
    private(set) var initialWord: String?

    // MARK: - Public Methods

    /// Задает изначальное слово
    func updateWord(_ word: String?) {
        initialWord = word
    }
}
