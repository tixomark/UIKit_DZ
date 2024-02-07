// GuessNumberGameModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Guess number game model
final class GuessNumberGame {
    // MARK: - Types

    enum PositionRelativeToTakenNumber {
        case isTakenNumber
        case greaterThanTakenNumer
        case lessThanTakenNumber
    }

    // MARK: - Public Properties

    var suggestedNumber = 1
    weak var delegate: GuessNumberGameDelegate?

    // MARK: - Private Properties

    private var number = Int.random(in: 1 ... 10)

    // MARK: - Public Methods

    func checkSuggestNumber() {
        if suggestedNumber > number {
            delegate?.suggestedNumber(.greaterThanTakenNumer)
        } else if suggestedNumber < number {
            delegate?.suggestedNumber(.lessThanTakenNumber)
        } else {
            number = Int.random(in: 1 ... 10)
            delegate?.suggestedNumber(.isTakenNumber)
        }
    }
}

protocol GuessNumberGameDelegate: AnyObject {
    func suggestedNumber(_ position: GuessNumberGame.PositionRelativeToTakenNumber)
}
