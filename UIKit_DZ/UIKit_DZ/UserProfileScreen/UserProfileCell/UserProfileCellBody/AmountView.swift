// AmountView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью со счетчиком и подписью под ним
final class AmountView: UIView {
    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 70, height: 29)
    }

    // MARK: - Private Properties

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = .verdanaBold?.withSize(14)
        label.textAlignment = .center
        return label
    }()

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = .verdana?.withSize(10)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Life Cycle

    init() {
        super.init(frame: .zero)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func setAmount(_ amount: Int) {
        amountLabel.text = "\(amount)"
    }

    func setCaption(_ caption: String?) {
        captionLabel.text = caption
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(amountLabel, captionLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: amountLabel, captionLabel)
        configureAmountLabelLayout()
        configureCaptionLabelLayout()
    }

    private func configureAmountLabelLayout() {
        [
            amountLabel.topAnchor.constraint(equalTo: topAnchor),
            amountLabel.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor),
            amountLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            amountLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ].activate()
    }

    private func configureCaptionLabelLayout() {
        [
            captionLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 2),
            captionLabel.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor),
            captionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            captionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            captionLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ].activate()
    }
}
