// DataProvider.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные всего приложения
final class DataProvider {
    // MARK: - Constants

    private enum Constants {
        static let likedText = " понравился ваш комментарий: "
        static let notionText = " упомянул(-а) вас в комментарии: "
        static let acquaintanceText = " появился(-ась) в RMLink. Вы можете быть знакомы "
        static let subscriptionText = " подписался(-ась) на ваши новости "
    }

    // MARK: - Private Properties

    /// Текущий авторизированный пользователь приложения
    var currentUser = CurrentUser(
        nickname: "mary_rmLink",
        username: "Мария Иванова",
        publicationsAmount: 67,
        subscribersAmount: 485,
        subscriptionsAmount: 120,
        occupation: "Консультат",
        link: "https://www.spacex.com/vehicles/starship/",
        profileImageName: .currentUserImage
    )

    /// Истории текущего автори зированного пользователя
    var currentUserStories: [UserStory] = [
        .init(imageName: .storyImage1, caption: "Запуск"),
        .init(imageName: .storyImage2, caption: "Луна"),
        .init(imageName: .storyImage3, caption: "Космонавт"),
        .init(imageName: .storyImage4, caption: "Космос"),
        .init(imageName: .storyImage1, caption: "Запуск"),
        .init(imageName: .storyImage2, caption: "Луна"),
        .init(imageName: .storyImage3, caption: "Космонавт"),
        .init(imageName: .storyImage4, caption: "Космос")
    ]

    var currentUserGallery: [AssetImageName] = [
        .galleryImage1, .galleryImage2, .galleryImage3, .galleryImage4,
        .galleryImage1, .galleryImage2, .galleryImage3, .galleryImage4,
        .galleryImage1, .galleryImage2, .galleryImage3, .galleryImage4,
        .galleryImage1, .galleryImage2, .galleryImage3, .galleryImage4,
        .galleryImage1, .galleryImage2, .galleryImage3, .galleryImage4
    ]

    /// Пользователи
    var users: [User] = [
        .init(nickname: "tixomark", profileImage: .myImage),
        .init(nickname: "12miho", profileImage: .userImage1),
        .init(nickname: "сrimea_082", profileImage: .userImage2),
        .init(nickname: "tur_v_dagestan", profileImage: .userImage3),
        .init(nickname: "lavanda123", profileImage: .userImage4),
        .init(nickname: "mary_pol", profileImage: .userImage5),
        .init(nickname: "markS", profileImage: .userImage6),
        .init(nickname: "sv_neit", profileImage: .userImage7),
    ]

    /// Нотификации
    lazy var notifications: [[Notificatable]] = [
        [
            Notion(
                user: users[4],
                text: Constants.likedText + "\"Очень красиво!\" ",
                timePassed: "12ч",
                detailImage: .photo3
            ),
            Notion(
                user: users[4],
                text: Constants.notionText + "@rm Спасибо! ",
                timePassed: "12ч",
                detailImage: .photo3
            )
        ],
        [
            Notion(
                user: users[4],
                text: Constants.likedText + "\"Это где?\" ",
                timePassed: "3д.",
                detailImage: .photo4
            ),
            Subscription(user: users[1], text: Constants.acquaintanceText, timePassed: "3д.", isSubscribed: false),
            Subscription(user: users[4], text: Constants.subscriptionText, timePassed: "5д.", isSubscribed: true),
            Notion(
                user: users[4],
                text: Constants.likedText + "\"Ты вернулась?\" ",
                timePassed: "7д.",
                detailImage: .photo4
            ),
            Subscription(user: users[6], text: Constants.acquaintanceText, timePassed: "8д.", isSubscribed: false),
            Subscription(user: users[7], text: Constants.acquaintanceText, timePassed: "8д.", isSubscribed: false)
        ]
    ]

    /// Истории
    lazy var stories: [Story] = {
        var array: [Story] = []
        array.append(.init(user: users[0], isWhatched: true))
        for index in 0 ... 10 {
            let randomUser = users[Int.random(in: 1 ... users.count - 1)]
            let story = Story(user: randomUser, isWhatched: Bool.random())
            array.append(story)
        }
        return array
    }()

    /// Рекомендации
    lazy var recomendations: [Recomendation] = {
        var array: [Recomendation] = []
        for index in 0 ... 10 {
            let randomUser = users[Int.random(in: 1 ... users.count - 1)]
            let recomendation = Recomendation(user: randomUser)
            array.append(recomendation)
        }
        return array
    }()

    /// Посты
    private lazy var posts: [Post] = [
        .init(
            user: users[3],
            images: [.photo1],
            numberOflikes: 201,
            text: " Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        ),
        .init(
            user: users[3],
            images: [.photo1, .photo2, .photo3],
            numberOflikes: 201,
            text: " Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        ),
        .init(
            user: users[3],
            images: [.photo1, .photo2],
            numberOflikes: 201,
            text: " Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        ),
        .init(
            user: users[3],
            images: [.photo1, .photo2],
            numberOflikes: 201,
            text: " Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        ),
        .init(
            user: users[3],
            images: [.photo1, .photo2],
            numberOflikes: 201,
            text: " Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        ),
        .init(
            user: users[3],
            images: [.photo1, .photo2],
            numberOflikes: 201,
            text: " Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        )
    ]

    func post(forRow row: Int, sectionType type: FeedViewController.FeedSectionType) -> Post {
        if case let .feedItems(amount) = type {
            if amount == 1 {
                return posts[row]
            } else {
                return posts[row + 1]
            }
        }
        return posts[0]
    }
}
