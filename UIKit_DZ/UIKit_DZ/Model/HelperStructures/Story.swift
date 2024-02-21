// Story.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// История от другого пользователя
struct Story {
    /// Пользователь с которым ассоциирована история
    var user: User
    /// Была ли уже данная история просмотрена текущим пользователем
    var isWhatched: Bool
}
