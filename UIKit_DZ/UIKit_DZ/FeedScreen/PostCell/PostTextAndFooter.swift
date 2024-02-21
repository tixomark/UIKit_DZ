// PostTextAndFooter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Нижняя часть ячейки поста c комментариями и
final class PostTextAndFooter: UIView {
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

    func configure(nickName: String, comment text: String) {
        let nickFont = UIFont.verdanaBold?.withSize(10) ?? UIFont.systemFont(ofSize: 10)
        let nickNameAttributes: [NSAttributedString.Key: Any] = [.font: nickFont, .foregroundColor: UIColor.accent]
        let postText = NSMutableAttributedString(string: nickName, attributes: nickNameAttributes)

        let commentFont = UIFont.verdana?.withSize(10) ?? UIFont.systemFont(ofSize: 10)
        let commentAttributes: [NSAttributedString.Key: Any] = [.font: commentFont, .foregroundColor: UIColor.accent]
        let commentText = NSAttributedString(string: text, attributes: commentAttributes)

        postText.append(commentText)
        postTextLabel.attributedText = postText
    }

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .systemBackground
        addSubviews(postTextLabel, currentUserImageView, commentLabel, editionTimeLabel)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(
            for: postTextLabel,
            currentUserImageView,
            commentLabel,
            editionTimeLabel
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

            editionTimeLabel.topAnchor.constraint(equalTo: currentUserImageView.bottomAnchor, constant: 4),
            editionTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            editionTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            editionTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].activate()
    }
}
