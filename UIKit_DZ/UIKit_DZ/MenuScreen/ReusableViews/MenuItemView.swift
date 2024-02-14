// MenuItemView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Описывает стандартный элемент меню с полем названия и изовражением
final class MenuItemView: UIView {
    // MARK: - Visual Components

    /// Название элемента меню
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 220, height: 19)
        label.frame.origin = CGPoint(x: 25, y: 30.5)

        label.textColor = .black
        label.font = UIFont(name: "Verdana-BoldItalic", size: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    /// Изображение элемента меню
    private let itemImageView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 70, height: 70)
        view.frame.origin = CGPoint(x: 252, y: 5)
        view.contentMode = .scaleAspectFit
        return view
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }

    // MARK: - Public Methods

    /// Конфигурирует отображение заполяя его данными
    func configureUsing(_ data: (String, UIImage?)) {
        nameLabel.text = data.0
        itemImageView.image = data.1
    }

    // MARK: - Private Methods

    private func setUpUI() {
        layer.cornerRadius = 16
        backgroundColor = .menuItemBackground
        addSubviews(nameLabel, itemImageView)
    }
}
