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
        view.layer.masksToBounds = false
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

    override func prepareForReuse() {
        super.prepareForReuse()
        storyImageView.image = nil
        captionLabel.text = nil
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
        addFrameToStoryImageView()
    }

    private func configureStoryImageViewLayout() {
        [
            storyImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
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
            captionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].activate()
    }

    private func addFrameToStoryImageView() {
        guard storyImageView.layer.sublayers == nil else { return }
        let backgroungLayer = CALayer()
        backgroungLayer.borderColor = UIColor.opaqueSeparator.cgColor

        let size = storyImageView.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .fittingSizeLevel
        )
        var frame = CGRect.zero
        frame.size = size
        backgroungLayer.frame = frame.insetBy(dx: -3, dy: -3)
        backgroungLayer.cornerRadius = backgroungLayer.frame.width / 2
        backgroungLayer.borderWidth = 1
        storyImageView.layer.addSublayer(backgroungLayer)
    }
}
