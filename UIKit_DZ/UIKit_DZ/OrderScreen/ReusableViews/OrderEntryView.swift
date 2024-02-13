// OrderEntryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Описывает стандартный элемент позиции чека
final class OrderEntryView: UIView {
    // MARK: - Visual Components

    /// Содержит название позиции чека
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 200, height: 30)
        label.frame.origin = .zero

        label.textColor = .black
        label.font = UIFont(name: "Verdana", size: 16)
        label.textAlignment = .left
        return label
    }()

    /// Содержит стоимость позиции чека
    private let costLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 150, height: 30)
        label.frame.origin = CGPoint(x: 185, y: 0)

        label.textColor = .black
        label.font = UIFont(name: "Verdana", size: 16)
        label.textAlignment = .right
        return label
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        var customFrame = frame
        customFrame.size = CGSize(width: 335, height: 30)
        super.init(frame: customFrame)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }

    // MARK: - Public Methods

    /// Устанавливает текстовые значения в лейблы
    func configureUsing(_ title: String?, cost: String?) {
        titleLabel.text = title
        costLabel.text = cost
    }

    /// Меняет стиль шрифта на жирный
    func switchToBoldFont() {
        let boldFont = UIFont(name: "Verdana-Bold", size: 16)
        titleLabel.font = boldFont
        costLabel.font = boldFont
    }

    // MARK: - Private Methods

    private func setUpUI() {
        addSubviews(titleLabel, costLabel)
    }
}
