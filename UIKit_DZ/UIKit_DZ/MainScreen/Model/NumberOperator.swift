// NumberOperator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Определяет методы по которым модель может сообщать о своих внутренних изменениях
protocol NumberOperatorResultReceiver: AnyObject {
    /// Принимает результат произведенной операции над двумя числами
    func operationResultedWith(_ number: Float?)
}

/// Модель производящая указанные операции над двумя числами.
final class NumberOperator {
    // MARK: - Public Properties

    var firstNumber: Float = 0
    var secondNumber: Float = 0
    var operation: ArithmeticOperation = .add
    var userName = ""

    /// Объект обрабатывающий результат проведенной операции
    weak var resultReceiver: NumberOperatorResultReceiver?

    // MARK: - Public Methods

    /// Выполняет защанную математическую операцию над firstNumber и secondNumber
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
        resultReceiver?.operationResultedWith(expresion.resolve())
    }
}
