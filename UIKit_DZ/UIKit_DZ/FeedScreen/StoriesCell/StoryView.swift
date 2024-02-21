// StoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью с изображением и подписью под ним
class StoryView: UIView {
    // MARK: - Visual Components

    private(set) var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        return view
    }()

    private(set) var nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = .verdana?.withSize(8)
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

    func configure(with story: Story) {
        imageView.image = UIImage(story.user.profileImage)
        nicknameLabel.text = story.user.nickname
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(imageView, nicknameLabel)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: imageView, nicknameLabel)
        [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

            nicknameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nicknameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nicknameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ].activate()
    }
}
