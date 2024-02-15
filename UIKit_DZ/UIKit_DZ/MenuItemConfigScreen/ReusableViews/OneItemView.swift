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

    private let mainImageView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 100, height: 100)
        view.frame.origin = CGPoint(x: 31, y: 17)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 165, height: 40)
        label.frame.origin = CGPoint(x: 0, y: 111)

        label.textColor = .black
        label.font = .verdana?.withSize(14)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        var customFrame = frame
        customFrame.size = CGSize(width: 165, height: 165)
        super.init(frame: customFrame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    // MARK: - Public Methods

    func setTitle(_ title: String?) {
        nameLabel.text = title
    }

    func setImage(_ image: UIImage?) {
        mainImageView.image = image
    }

    func setState(to newState: State) {
        layer.borderWidth = (newState == .highlited) ? 1 : 0
    }

    func setSizeImage(_ width: CGFloat, _ height: CGFloat) {
        mainImageView.frame.size = CGSize(width: width, height: height)
        mainImageView.frame.origin = CGPoint(x: 67, y: 56)
    }

    // MARK: - Private Methods

    private func configureUI() {
        layer.cornerRadius = 12
        layer.borderColor = UIColor.torquoiseAccent.cgColor
        backgroundColor = .secondarySystemFill
        layer.cornerCurve = .continuous
        addSubviews(nameLabel, mainImageView)
    }
}
