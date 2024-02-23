// OneImageCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с состоящая только из одного изображения
final class OneImageCollectionViewCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let galleryImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
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

    func configure(with image: UIImage?) {
        galleryImageView.image = image
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(galleryImageView)
        clipsToBounds = true
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: galleryImageView)
        [
            galleryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            galleryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            galleryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            galleryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            galleryImageView.widthAnchor.constraint(equalTo: galleryImageView.heightAnchor)
        ].activate()
    }
}
