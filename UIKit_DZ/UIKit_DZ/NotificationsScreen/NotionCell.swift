// NotionCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка использующаяся для отображения упоминания или комментария
final class NotionCell: UITableViewCell {
    // MARK: - Visual Components

    private let userImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.textAlignment = .left
        label.font = .verdana?.withSize(12)
        label.numberOfLines = 0
        return label
    }()

    private let detailImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

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

    func configure(with notion: Notion) {
        userImageView.image = UIImage(notion.user.profileImage)
        detailImageView.image = UIImage(notion.detailImage)

        let infoText = notion.user.nickname.attributed()
            .withColor(.accent)
            .withFont(.verdanaBold?.withSize(12))
        infoText.append(
            notion.text.attributed()
                .withColor(.accent)
                .withFont(.verdana?.withSize(12))
        )
        infoText.append(
            notion.timePassed.attributed()
                .withColor(.opaqueSeparator)
                .withFont(.verdana?.withSize(12))
        )

        infoLabel.attributedText = infoText
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubviews(userImageView, infoLabel, detailImageView)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: userImageView, infoLabel, detailImageView)
        [
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor),
            userImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 7),
            infoLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            detailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            detailImageView.leadingAnchor.constraint(greaterThanOrEqualTo: infoLabel.trailingAnchor, constant: 10),
            detailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            detailImageView.heightAnchor.constraint(equalToConstant: 40),
            detailImageView.widthAnchor.constraint(equalTo: detailImageView.widthAnchor)
        ].activate()
    }
}
