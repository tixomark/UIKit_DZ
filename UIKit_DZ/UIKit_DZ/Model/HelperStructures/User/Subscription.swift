// Subscription.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Нотификация о появлении или подписках пользователей
struct Subscription: Notificatable {
    /// Пользователь к которому относится нотификация
    var user: User
    /// Сообщение нотификации
    var text: String
    /// Количество времени, которое прошло с момента того действия, о котором сообщает нотификация
    var timePassed: String
    /// Подписан ли авторизированный пользователь на предлагаемого
    var isSubscribed: Bool
}
