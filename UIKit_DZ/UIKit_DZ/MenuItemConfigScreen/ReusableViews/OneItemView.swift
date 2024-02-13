// OneItemView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Описывает стандартный элемент меню с полем названия и изовражением
final class OneItemView: UIView {
    // MARK: - Types

    /// Описывает визуальное состояние представления
    enum State {
        /// Представление выделено рамко шириной в 1 поитн
        case highlited
        /// Представление без выделения
        case normal
    }

    // MARK: - Visual Components

    /// Содержит изображения элемента
    private let image: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 100, height: 100)
        view.frame.origin = CGPoint(x: 31, y: 17)
        view.contentMode = .scaleAspectFit
        return view
    }()

    /// Содержит название элемента
    private let label: UILabel = {
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

    /// Устанавливает текст отображения
    func setTitle(_ title: String?) {
        label.text = title
    }

    /// Устанавливает изображение отображения
    func setImage(_ image: UIImage?) {
        self.image.image = image
    }

    /// Устанавливает выделение отображения
    func setState(to newState: State) {
        layer.borderWidth = (newState == .highlited) ? 1 : 0
    }

    // MARK: - Private Methods

    private func setUpUI() {
        layer.cornerRadius = 12
        layer.borderColor = UIColor.torquoiseAccent.cgColor
        backgroundColor = .secondarySystemFill
        layer.cornerCurve = .continuous
        addSubviews(label, image)
    }
}
