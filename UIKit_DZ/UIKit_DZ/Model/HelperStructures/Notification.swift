// Notification.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Общий протокол для объектов, которые могут выступать с качестве нотификаций
protocol Notificatable {
    /// Пользователь к которому относится нотификация
    var user: User { get set }
    /// Сообщение нотификации
    var text: String { get set }
    /// Количество времени, которое прошло с момента того действия, о котором сообщает нотификация
    var timePassed: String { get set }
}
