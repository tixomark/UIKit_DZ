// Notion.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Нотификация о каком либо упоминании или комментарии
struct Notion: Notificatable {
    var user: User
    var text: String
    var timePassed: String
    /// Дополнительное  изображение из места упоминания
    var detailImage: AssetImageName
}
