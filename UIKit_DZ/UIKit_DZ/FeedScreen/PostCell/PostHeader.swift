// PostHeader.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Хедер ячейки поста с информацией о владельце данного поста
final class PostHeader: UIView {
    // MARK: - Visual Components

    private let userIconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = .verdanaBold?.withSize(12)
        label.textAlignment = .left
        return label
    }()

    private let moreImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = .moreIcon.withTintColor(.accent)
        return view
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

    func configure(with user: User) {
        userIconImageView.image = UIImage(user.profileImage)
        nicknameLabel.text = user.nickname
    }

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .systemBackground
        addSubviews(userIconImageView, nicknameLabel, moreImageView)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: userIconImageView, nicknameLabel, moreImageView)
        [
            userIconImageView.topAnchor.constraint(equalTo: topAnchor),
            userIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            userIconImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            userIconImageView.heightAnchor.constraint(equalToConstant: 30),
            userIconImageView.widthAnchor.constraint(equalTo: userIconImageView.heightAnchor),

            nicknameLabel.leadingAnchor.constraint(equalTo: userIconImageView.trailingAnchor, constant: 8),
            nicknameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            moreImageView.leadingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor, constant: 10),
            moreImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            moreImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ].activate()
    }
}
