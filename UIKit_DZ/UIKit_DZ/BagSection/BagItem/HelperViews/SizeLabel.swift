// SizeLabel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Лейбл с возможность менять рамку по переключателю
final class SizeLabel: UILabel {
    // MARK: - Types

    /// Определяет визуальные состояния представления
    enum State {
        /// Представление выделено рамко шириной в 1 поитн
        case highlited
        /// Представление без выделения
        case normal
    }

    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 31, height: 17)
    }

    // MARK: - Life Cycle

    init() {
        super.init(frame: .zero)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    // MARK: - Public Methods

    func setState(to newState: State) {
        layer.borderWidth = (newState == .highlited) ? 1 : 0
    }

    // MARK: - Private Methods

    private func configureUI() {
        textColor = .black
        font = .verdana?.withSize(10)
        textAlignment = .center

        layer.cornerRadius = 8.5
        layer.borderColor = UIColor.accentPink.cgColor
        backgroundColor = .shallowPink
        clipsToBounds = true
        layer.cornerCurve = .continuous
    }
}
