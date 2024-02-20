// PostTextAndFooter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Нижняя часть ячейки поста
final class PostTextAndFooter: UIView {
    // MARK: - Constants

    private enum Constants {
        static let commentLabelText = "Комментировать ..."
        static let lastSeenText = "10 минут назад"
    }

    // MARK: - Visual Components

    private let postTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = .verdana?.withSize(10)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let currentUserImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(.myImage)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    private let commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .opaqueSeparator
        label.font = .verdana?.withSize(10)
        label.textAlignment = .left
        label.text = Constants.commentLabelText
        return label
    }()

    private let lastSeenLabel: UILabel = {
        let label = UILabel()
        label.textColor = .opaqueSeparator
        label.font = .verdana?.withSize(10)
        label.textAlignment = .left
        label.text = Constants.lastSeenText
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

    func configure(nickName: String?, comment text: String?) {
        postTextLabel.text = (nickName ?? "") + (text ?? "")
    }

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .systemBackground
        addSubviews(postTextLabel, currentUserImageView, commentLabel, lastSeenLabel)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(
            for: postTextLabel,
            currentUserImageView,
            commentLabel,
            lastSeenLabel
        )
        [
            postTextLabel.topAnchor.constraint(equalTo: topAnchor),
            postTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            postTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            currentUserImageView.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 4),
            currentUserImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            currentUserImageView.heightAnchor.constraint(equalToConstant: 20),
            currentUserImageView.widthAnchor.constraint(equalTo: currentUserImageView.heightAnchor),

            commentLabel.leadingAnchor.constraint(equalTo: currentUserImageView.trailingAnchor, constant: 3),
            commentLabel.centerYAnchor.constraint(equalTo: currentUserImageView.centerYAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            lastSeenLabel.topAnchor.constraint(equalTo: currentUserImageView.bottomAnchor, constant: 4),
            lastSeenLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            lastSeenLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            lastSeenLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].activate()
    }
}
