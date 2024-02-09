// CUIButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шаблон кнопки с преднастроенными свойствами для использования там где понадобится.
final class CUIButton: UIButton {
    // MARK: - Life Cycle

    init() {
        super.init(frame: .zero)
        setUpUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }

    // MARK: - Private Methods

    private func setUpUI() {
        layer.borderWidth = 3
        layer.cornerRadius = 30
        titleLabel?.font = UIFont(name: "Verdana-Bold", size: 20)
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = .systemBackground
        titleEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        titleLabel?.numberOfLines = 0
    }
}
