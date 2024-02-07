// ArithmeticExpression.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Calculator expressions
enum ArithmeticExpression<Value: SignedNumeric & FloatingPoint> {
    case value(Value)
    indirect case add(ArithmeticExpression, ArithmeticExpression)
    indirect case subtract(ArithmeticExpression, ArithmeticExpression)
    indirect case multiply(ArithmeticExpression, ArithmeticExpression)
    indirect case divide(ArithmeticExpression, ArithmeticExpression)

    // MARK: - Public Properties

    func resolve() -> Value {
        switch self {
        case let .value(value):
            value
        case let .add(operand1, operand2):
            operand1.resolve() + operand2.resolve()
        case let .subtract(operand1, operand2):
            operand1.resolve() - operand2.resolve()
        case let .multiply(operand1, operand2):
            operand1.resolve() * operand2.resolve()
        case let .divide(operand1, operand2):
            operand1.resolve() / operand2.resolve()
        }
    }
}
