// DataStore.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class DataStore {
    var users: [User] = [
        .init(nickname: "tixomark", profileImage: .myImage),
        .init(nickname: "12miho", profileImage: .userImage1),
        .init(nickname: "сrimea_082", profileImage: .userImage2),
        .init(nickname: "tur_v_dagestan", profileImage: .userImage3),
        .init(nickname: "lavanda123", profileImage: .userImage4),
        .init(nickname: "mary_pol", profileImage: .userImage5)
    ]

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

    lazy var posts: [Post] = [
        .init(
            user: users[3],
            images: [.photo1, .photo2],
            numberOflikes: 201,
            text: "Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        ),
        .init(
            user: users[3],
            images: [.photo1, .photo2],
            numberOflikes: 201,
            text: "Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        ),
        .init(
            user: users[3],
            images: [.photo1, .photo2],
            numberOflikes: 201,
            text: "Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        ),
        .init(
            user: users[3],
            images: [.photo1, .photo2],
            numberOflikes: 201,
            text: "Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        ),
        .init(
            user: users[3],
            images: [.photo1, .photo2],
            numberOflikes: 201,
            text: "Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        ),
        .init(
            user: users[3],
            images: [.photo1, .photo2],
            numberOflikes: 201,
            text: "Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        )
    ]

    lazy var recomendations: [Recomendation] = {
        var array: [Recomendation] = []
        for index in 0 ... 10 {
            let randomUser = users[Int.random(in: 1 ... users.count - 1)]
            let recomendation = Recomendation(user: randomUser)
            array.append(recomendation)
        }
        return array
    }()
}
