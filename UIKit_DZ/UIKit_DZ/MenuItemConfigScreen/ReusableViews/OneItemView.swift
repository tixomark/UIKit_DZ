// OneItemView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Описывает стандартный элемент меню с полем названия и изовражением
final class OneItemView: UIView {
    // MARK: - Types

    /// Определяет визуальные состояния представления
    enum State {
        /// Представление выделено рамко шириной в 1 поитн
        case highlited
        /// Представление без выделения
        case normal
    }

    // MARK: - Visual Components

    /// Главное изображение по центру
    private let mainImageView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 100, height: 100)
        view.frame.origin = CGPoint(x: 31, y: 17)
        view.contentMode = .scaleAspectFit
        return view
    }()

    /// Содержит название элемента
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 165, height: 34)
        label.frame.origin = CGPoint(x: 0, y: 117)

        label.textColor = .black
        label.font = UIFont(name: "Verdana", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        var customFrame = frame
        customFrame.size = CGSize(width: 165, height: 165)
        super.init(frame: customFrame)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }

    // MARK: - Public Methods

    /// Устанавливает название элемента
    func setTitle(_ title: String?) {
        nameLabel.text = title
    }

    /// Устанавливает главное изображение
    func setImage(_ image: UIImage?) {
        mainImageView.image = image
    }

    /// Устанавливает состояние - выделенное или обычное
    func setState(to newState: State) {
        layer.borderWidth = (newState == .highlited) ? 1 : 0
    }

    // MARK: - Private Methods

    private func setUpUI() {
        layer.cornerRadius = 12
        layer.borderColor = UIColor.torquoiseAccent.cgColor
        backgroundColor = .secondarySystemFill
        layer.cornerCurve = .continuous
        addSubviews(nameLabel, mainImageView)
    }
}
