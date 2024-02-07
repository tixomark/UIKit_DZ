// NumberOperationModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Main screen Model
class NumberOperationModel {
    // MARK: - Public Properties

    var firstNumber: Float = 0
    var secondNumber: Float = 0
    var operation: ArithmeticOperation = .add
    var userName = ""

    weak var delegate: NumberOperationModelDelegate?

    // MARK: - Public Methods

    func performOperation() {
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
        delegate?.operationResultedWith(expresion.resolve())
    }
}

protocol NumberOperationModelDelegate: AnyObject {
    func operationResultedWith(_ number: Float)
}
