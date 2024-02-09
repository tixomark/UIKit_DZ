// ArithmeticExpression.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Позволяет строить последовательности математических операций и выполнять их
enum ArithmeticExpression<Value: SignedNumeric & FloatingPoint> {
    /// Представление числа
    case value(Value)
    /// Сложение
    indirect case add(ArithmeticExpression, ArithmeticExpression)
    /// Вычитание второго числа из первого
    indirect case subtract(ArithmeticExpression, ArithmeticExpression)
    /// Умножение
    indirect case multiply(ArithmeticExpression, ArithmeticExpression)
    /// Деление первого числа на второе
    indirect case divide(ArithmeticExpression, ArithmeticExpression)

    // MARK: - Public Properties

    /// Итерируется по вложенным case и разрашеет их в соответствии с математической операцией
    func resolve() -> Value? {
        switch self {
        case let .value(value):
            return value
        case let .add(operand1, operand2):
            guard let result1 = operand1.resolve(),
                  let result2 = operand2.resolve() else { return nil }
            return result1 + result2
        case let .subtract(operand1, operand2):
            guard let result1 = operand1.resolve(),
                  let result2 = operand2.resolve() else { return nil }
            return result1 - result2
        case let .multiply(operand1, operand2):
            guard let result1 = operand1.resolve(),
                  let result2 = operand2.resolve() else { return nil }
            return result1 * result2
        case let .divide(operand1, operand2):
            guard let result1 = operand1.resolve(),
                  let result2 = operand2.resolve() else { return nil }
            guard result2 != 0 else {
                print("Can not divide by 0")
                return nil
            }
            return result1 / result2
        }
    }
}
