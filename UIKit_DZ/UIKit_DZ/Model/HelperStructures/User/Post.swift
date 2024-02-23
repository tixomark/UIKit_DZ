// Post.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Пост в ленте
struct Post {
    /// Пользователь владелец поста
    var user: User
    /// Прикрепленные к посту изображения
    var images: [AssetImageName]
    /// Количество лайков на посте
    var numberOflikes: Int
    /// Текст поста
    var text: String
}
