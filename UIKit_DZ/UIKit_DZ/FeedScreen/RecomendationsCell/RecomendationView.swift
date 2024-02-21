// RecomendationView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью используемая в качестве ячейки для раздела рекомендаций
final class RecomendationView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let subscribeText = "Подписаться"
    }

    // MARK: - Visual Components

    private let userIconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 57.5
        view.clipsToBounds = true
        return view
    }()

    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = .verdana?.withSize(10)
        label.textAlignment = .center
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.crossIcon.withTintColor(.accent), for: .normal)
        return button
    }()

    private let subscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.subscribeText, for: .normal)
        button.titleLabel?.font = .verdanaBold?.withSize(10)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        return button
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

    func configure(with recomendation: Recomendation) {
        userIconImageView.image = UIImage(recomendation.user.profileImage)
        nicknameLabel.text = recomendation.user.nickname
    }

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .systemBackground
        addSubviews(closeButton, userIconImageView, nicknameLabel, subscribeButton)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(
            for: closeButton,
            userIconImageView,
            nicknameLabel,
            subscribeButton
        )
        [
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8.5),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.5),
            closeButton.heightAnchor.constraint(equalToConstant: 7),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),

            userIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            userIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            userIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            userIconImageView.heightAnchor.constraint(equalToConstant: 115),
            userIconImageView.widthAnchor.constraint(equalTo: userIconImageView.heightAnchor),

            nicknameLabel.topAnchor.constraint(equalTo: userIconImageView.bottomAnchor, constant: 5),
            nicknameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            subscribeButton.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 9),
            subscribeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            subscribeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            subscribeButton.heightAnchor.constraint(equalToConstant: 30),
            subscribeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14)
        ].activate()
    }
}
