// PostCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка используемая для отображения данных о посте
final class PostCell: UITableViewCell {
    // MARK: - Visual Components

    private let postHeaderView = PostHeaderView()
    private let postBodyView = PostBodyView()
    private let postFooterView = PostFooterView()

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func configure(with post: Post) {
        postHeaderView.configure(with: post.user)
        postBodyView.configure(images: post.images, numberOfLikes: post.numberOflikes)
        postFooterView.configure(nickName: post.user.nickname, comment: post.text)
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubviews(postHeaderView, postBodyView, postFooterView)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: postHeaderView, postBodyView, postFooterView)
        [
            postHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            postHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            postBodyView.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor, constant: 10),
            postBodyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postBodyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            postFooterView.topAnchor.constraint(equalTo: postBodyView.bottomAnchor, constant: 6),
            postFooterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postFooterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postFooterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ].activate()
    }
}
