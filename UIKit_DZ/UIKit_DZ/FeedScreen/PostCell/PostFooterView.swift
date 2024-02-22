// PostFooterView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Нижняя часть ячейки поста c комментариями и
final class PostFooterView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let commentLabelText = "Комментировать ..."
        static let editionTimeText = "10 минут назад"
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

    private let editionTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .opaqueSeparator
        label.font = .verdana?.withSize(10)
        label.textAlignment = .left
        label.text = Constants.editionTimeText
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

    func configure(nickname: String, comment text: String) {
        let postText = nickname.attributed()
            .withColor(.accent)
            .withFont(.verdanaBold?.withSize(10))
        postText.append(
            text.attributed()
                .withColor(.accent)
                .withFont(.verdana?.withSize(10))
        )
        postTextLabel.attributedText = postText
    }

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .systemBackground
        addSubviews(postTextLabel, currentUserImageView, commentLabel, editionTimeLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: postTextLabel, currentUserImageView, commentLabel, editionTimeLabel)
        configurePostTextLabelLayout()
        configureCurrentUserImageViewLayout()
        configureCommentLabelLayout()
        configureEditionTimeLabelLayout()
    }

    private func configurePostTextLabelLayout() {
        [
            postTextLabel.topAnchor.constraint(equalTo: topAnchor),
            postTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            postTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ].activate()
    }

    private func configureCurrentUserImageViewLayout() {
        [
            currentUserImageView.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 4),
            currentUserImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            currentUserImageView.heightAnchor.constraint(equalToConstant: 20),
            currentUserImageView.widthAnchor.constraint(equalTo: currentUserImageView.heightAnchor),
        ].activate()
    }

    private func configureCommentLabelLayout() {
        [
            commentLabel.leadingAnchor.constraint(equalTo: currentUserImageView.trailingAnchor, constant: 3),
            commentLabel.centerYAnchor.constraint(equalTo: currentUserImageView.centerYAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ].activate()
    }

    private func configureEditionTimeLabelLayout() {
        [
            editionTimeLabel.topAnchor.constraint(equalTo: currentUserImageView.bottomAnchor, constant: 4),
            editionTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            editionTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            editionTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].activate()
    }
}
