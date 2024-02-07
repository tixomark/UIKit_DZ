// Model.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Main screen Model
class Model {
    // MARK: - Public Properties

    var firstNumber: Float = 0
    var secondNumber: Float = 0
    var operation: ArithmeticOperation = .add
    var userName = ""

    // MARK: - Public Methods

    func performOperation() -> Float {
        let expresion: ArithmeticExpression = switch operation {
        case .add:
            .add(.value(firstNumber), .value(secondNumber))
        case .subtract:
            .subtract(.value(firstNumber), .value(secondNumber))
        case .multiply:
            .multiply(.value(firstNumber), .value(secondNumber))
        case .divide:
            .divide(.value(firstNumber), .value(secondNumber))
        }
        firstNumber = 0
        secondNumber = 0
        return expresion.resolve()
    }
}
