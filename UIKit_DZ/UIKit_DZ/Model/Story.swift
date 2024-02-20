// Story.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Описание истории
struct Story {
    /// Пользователь с которым ассоыиирована история
    var user: User
    /// Была ли уже данная история просмотрена текущим пользователем
    var isWhatched: Bool
}
