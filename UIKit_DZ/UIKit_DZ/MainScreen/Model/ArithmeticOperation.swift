// ArithmeticOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Список возможных арифметических операций с их названиями
enum ArithmeticOperation: String, CaseIterable {
    /// Сложение
    case add = "Сложить"
    /// Вычитание
    case subtract = "Вычесть"
    /// Умножение
    case multiply = "Умножить"
    /// Деление
    case divide = "Разделить"
}
