// Subscription.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Нотификация о появлении или подписках пользователей
struct Subscription: Notificatable {
    var user: User
    var text: String
    var timePassed: String
    /// Подписан ли авторизированный пользователь на предлагаемого
    var isSubscribed: Bool
}
