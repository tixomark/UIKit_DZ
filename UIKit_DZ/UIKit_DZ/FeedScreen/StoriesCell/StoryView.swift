// StoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Иконка пользователя с подписью снизу
class StoryView: UIView {
    // MARK: - Visual Components

    private(set) var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        return view
    }()

    private(set) var label: UILabel = {
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
        label.text = story.user.nickname
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(imageView, label)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: imageView, label)
        [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ].activate()
    }
}
