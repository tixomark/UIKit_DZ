// UserStoryCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью с изображением истории и подписью
class UserStoryCollectionViewCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let storyImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = .verdana?.withSize(10)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func configure(with story: UserStory) {
        storyImageView.image = UIImage(story.imageName)
        captionLabel.text = story.caption
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(storyImageView, captionLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: storyImageView, captionLabel)
        configureStoryImageViewLayout()
        configureCaptionLabelLayout()
    }

    private func configureStoryImageViewLayout() {
        [
            storyImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            storyImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            storyImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            storyImageView.heightAnchor.constraint(equalToConstant: 50),
            storyImageView.widthAnchor.constraint(equalTo: storyImageView.heightAnchor)
        ].activate()
    }

    private func configureCaptionLabelLayout() {
        [
            captionLabel.topAnchor.constraint(equalTo: storyImageView.bottomAnchor, constant: 7),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            captionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ].activate()
    }
}
