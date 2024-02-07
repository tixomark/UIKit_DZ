// Model.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Main screen Model
class Model {
    var firstNumber = 0
    var secondNumber = 0

    var userName = ""

    func performOperation(_ operatrion: ArithmeticOperation) -> Int {
        let expresion: ArithmeticExpression = switch operatrion {
        case .add:
            .add(.value(firstNumber), .value(secondNumber))
        case .subtract:
            .add(.value(firstNumber), .value(secondNumber))
        case .multiply:
            .add(.value(firstNumber), .value(secondNumber))
        case .divide:
            .add(.value(firstNumber), .value(secondNumber))
        }
        firstNumber = 0
        secondNumber = 0
        return expresion.resolve()
    }
}
