// PostHeader.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Верхняя часть ячейки поста
final class PostHeader: UIView {
    // MARK: - Visual Components

    private let userIconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    private let nicknameLable: UILabel = {
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
        nicknameLable.text = user.nickname
    }

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .systemBackground
        addSubviews(userIconImageView, nicknameLable, moreImageView)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: userIconImageView, nicknameLable, moreImageView)
        [
            userIconImageView.topAnchor.constraint(equalTo: topAnchor),
            userIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            userIconImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            userIconImageView.heightAnchor.constraint(equalToConstant: 30),
            userIconImageView.widthAnchor.constraint(equalTo: userIconImageView.heightAnchor),

            nicknameLable.leadingAnchor.constraint(equalTo: userIconImageView.trailingAnchor, constant: 8),
            nicknameLable.centerYAnchor.constraint(equalTo: centerYAnchor),

            moreImageView.leadingAnchor.constraint(equalTo: nicknameLable.trailingAnchor, constant: 10),
            moreImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            moreImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

        ].activate()
    }
}
