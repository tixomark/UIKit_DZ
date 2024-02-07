// ArithmeticExpression.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Calculator expressions
enum ArithmeticExpression<Value: Numeric> {
    case value(Value)
    indirect case add(ArithmeticExpression, ArithmeticExpression)

    func resolve() -> Value {
        switch self {
        case let .value(value):
            value
        case let .add(operand1, operand2):
            operand1.resolve() + operand2.resolve()
        }
    }
}
