// GuessNumberGame.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Определяет методы по которым модель может сообщать о своих внутренних изменениях
protocol GuessNumberGameResultReceiver: AnyObject {
    /// Содержит результат попытки сравнения загаданного числа с предложенным
    func suggestedNumber(_ position: GuessNumberGame.PositionRelativeToTakenNumber)
}

/// Модель игры в угадайку числа в заданном диапазоне
final class GuessNumberGame {
    // MARK: - Types

    /// Отношения между загаданным и предлагаемым числами
    enum PositionRelativeToTakenNumber {
        /// Предложенное число является загаданным
        case isTakenNumber
        /// Предложенное число больше загаданного
        case greaterThanTakenNumer
        /// Предложенное число меньше загаданного
        case lessThanTakenNumber
    }

    // MARK: - Constants

    enum Constants {
        static let defaultRange = 1 ... 10
    }

    // MARK: - Public Properties

    /// Предлагаемое игроком  число к проверке совпадения я загаданным
    var suggestedNumber = 1
    /// Объект получающий обновления по поводу совпадения предложенного и загаданного чисел
    weak var resultReceiver: GuessNumberGameResultReceiver?

    // MARK: - Private Properties

    /// Загаданное число
    private lazy var takenNumber = generateNewTakenNumber()

    // MARK: - Public Methods

    // Сравнивает загаданное число с предложенным передает результат в resultReceiver
    func checkSuggestNumber() {
        if suggestedNumber > takenNumber {
            resultReceiver?.suggestedNumber(.greaterThanTakenNumer)
        } else if suggestedNumber < takenNumber {
            resultReceiver?.suggestedNumber(.lessThanTakenNumber)
        } else {
            resultReceiver?.suggestedNumber(.isTakenNumber)
            // если числа совпали, загадывает новое число
            takenNumber = generateNewTakenNumber()
        }
    }

    // MARK: - Private Methods

    /// Загадывает новое число в стандартном диапазоне
    private func generateNewTakenNumber() -> Int {
        Int.random(in: Constants.defaultRange)
    }
}
