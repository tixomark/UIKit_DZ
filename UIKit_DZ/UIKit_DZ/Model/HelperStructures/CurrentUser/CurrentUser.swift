// CurrentUser.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Текущий авторизированный пользователь приложения
struct CurrentUser {
    /// Никнейм
    var nickname: String
    /// Имя
    var username: String
    /// Количество публикаций
    var publicationsAmount: Int
    /// Количество подписчиков
    var subscribersAmount: Int
    /// Количество подписок
    var subscriptionsAmount: Int
    /// Область занятости
    var occupation: String
    /// Ссылка на ресурс
    var link: String
    /// Изобаржение профиля пользователя
    var profileImageName: AssetImageName
}
