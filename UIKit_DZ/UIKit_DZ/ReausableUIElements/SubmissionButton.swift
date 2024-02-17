// SubmissionButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кнопка подтверждения
final class SubmissionButton: UIButton {
    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 100, height: 44)
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
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.25
        layer.shadowOffset.height = 4
        layer.cornerCurve = .continuous
        backgroundColor = .accentPink
        titleLabel?.font = .verdanaBold?.withSize(16)
    }
}
