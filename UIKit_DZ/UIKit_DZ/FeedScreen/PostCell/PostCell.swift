// PostCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class PostCell: UITableViewCell {
    // MARK: - Visual Components

    private let header = PostHeader()
    private let body = PostBody()
    private let textAndFooter = PostTextAndFooter()

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
        header.configure(with: post.user)
        body.configure(images: post.images, numberOfLikes: post.numberOflikes)
        textAndFooter.configure(nickName: post.user.nickname, comment: post.text)
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubviews(header, body, textAndFooter)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: header, body, textAndFooter)
        [
            header.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            body.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            body.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            body.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            textAndFooter.topAnchor.constraint(equalTo: body.bottomAnchor, constant: 6),
            textAndFooter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textAndFooter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textAndFooter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ].activate()
    }
}
