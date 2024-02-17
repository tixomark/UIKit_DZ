// CartModel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Модель отвечающая за реализацию корзины юзера
final class Cart {
    // MARK: - Types

    /// Шаблон обьекта корзины
    struct CartItem: Equatable {
        /// Уникальный идентификатор
        private let ID = UUID()
        /// Изображение товара
        var image: UIImage
        /// Цена товара
        var price: Int
        /// Размер товара
        var size: Int?
        /// Есть ли товар в корзине
        var isInCart: Bool
        /// Количество данного товара в корзине
        var amount = 0
    }

    // MARK: - Public Properties

    /// Суммарная стоимость элементов в корзине
    var cartCost: Int {
        items.reduce(0) { $0 + $1.price * $1.amount }
    }

    var items: [CartItem] = [
        .init(image: .shoeImage6, price: 2250, isInCart: false),
        .init(image: .shoeImage7, price: 4250, isInCart: false),
        .init(image: .shoeImage8, price: 5750, isInCart: false),
        .init(image: .shoeImage9, price: 3500, isInCart: false),
        .init(image: .shoeImage10, price: 5750, isInCart: false)
    ]
}
