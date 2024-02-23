// ActionButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Пользовательская кнопка для обозначения возможности какого либо рода действий
final class ActionButton: UIButton {
    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 25, height: 27)
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

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .opaqueSeparator.withAlphaComponent(0.7)
        layer.cornerRadius = 8
        titleLabel?.font = .verdanaBold?.withSize(10)
        titleLabel?.textAlignment = .center
        setTitleColor(.accent, for: .normal)
    }
}
