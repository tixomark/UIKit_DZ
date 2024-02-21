// Notion.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Нотификация о каком либо упоминании или комментарии
struct Notion: Notificatable {
    /// Пользователь к которому относится нотификация
    var user: User
    /// Сообщение нотификации
    var text: String
    /// Количество времени, которое прошло с момента того действия, о котором сообщает нотификация
    var timePassed: String
    /// Дополнительное  изображение из места упоминания
    var detailImage: AssetImageName
}
