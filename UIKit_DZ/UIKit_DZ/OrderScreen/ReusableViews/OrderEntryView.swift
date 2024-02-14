// OrderEntryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Описывает элемент позиции чека
final class OrderEntryView: UIView {
    // MARK: - Visual Components

    /// Название позиции чека
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 200, height: 30)
        label.frame.origin = .zero

        label.textColor = .black
        label.font = .verdana?.withSize(16)
        label.textAlignment = .left
        return label
    }()

    /// Стоимость позиции чека
    private let costLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 150, height: 30)
        label.frame.origin = CGPoint(x: 185, y: 0)

        label.textColor = .black
        label.font = .verdana?.withSize(16)
        label.textAlignment = .right
        return label
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        var customFrame = frame
        customFrame.size = CGSize(width: 335, height: 30)
        super.init(frame: customFrame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    // MARK: - Public Methods

    func configureUsing(_ title: String?, cost: String?) {
        titleLabel.text = title
        costLabel.text = cost
    }

    func switchToBoldFont() {
        titleLabel.font = .verdanaBold?.withSize(16)
        costLabel.font = .verdanaBold?.withSize(16)
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(titleLabel, costLabel)
    }
}
