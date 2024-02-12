// BirthdayCalculator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Служит для рассчета даты
struct BirthdayCalculator {
    // MARK: - Public Methods

    /// Возвращает количество лет прошедших с указанной даты
    func yearsSince(_ date: Date) -> Int {
        Calendar(identifier: .gregorian).dateComponents([.year], from: date, to: Date()).year ?? 0
    }

    /// Возвращает количество дней до указанного дня рождения
    func daysUntil(_ date: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        var comp = calendar.dateComponents(in: .current, from: date)

        guard let year = calendar.dateComponents([.year], from: Date()).year else { return 0 }
        comp.year = year
        comp.yearForWeekOfYear = year

        guard let sameDayThisYear = comp.date else { return 0 }

        if Date() > sameDayThisYear {
            comp.year = year + 1
            comp.yearForWeekOfYear = year + 1
        }

        guard let comparingDate = comp.date else { return 0 }

        let dateComp = calendar.dateComponents(
            [.day],
            from: Date(),
            to: comparingDate
        )
        guard let day = dateComp.day else { return 0 }
        return day
    }
}
