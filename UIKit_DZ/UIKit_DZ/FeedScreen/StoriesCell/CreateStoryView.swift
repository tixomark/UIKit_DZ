// CreateStoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Наследник от StoryView с дополнительной иконкой плюса в правом нижнем углу
final class CreateStoryView: StoryView {
    private enum Constants {
        static let plusImage: UIImage = .plusIcon.withTintColor(.systemBackground)
    }

    // MARK: - Visual Components

    private let addImageView: UIImageView = {
        let view = UIImageView(image: Constants.plusImage)
        view.contentMode = .center
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemRed
        return view
    }()

    // MARK: - Life Cycle

    override init() {
        super.init()
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        nicknameLabel.textColor = .opaqueSeparator
        addSubviews(addImageView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: addImageView)
        configureAddImageViewLayout()
    }

    private func configureAddImageViewLayout() {
        [
            addImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            addImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            addImageView.heightAnchor.constraint(equalToConstant: 20),
            addImageView.widthAnchor.constraint(equalTo: addImageView.heightAnchor),
        ].activate()
    }
}
