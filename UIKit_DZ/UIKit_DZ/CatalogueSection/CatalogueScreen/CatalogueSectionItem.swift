// CatalogueSectionItem.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class CatalogueSectionItem: UIView {
    // MARK: - Visual Components

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .verdanaBold?.withSize(14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 80)
    }

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

    func setTitle(_ title: String?) {
        label.text = title
    }

    func setImage(_ image: UIImage?) {
        imageView.image = image
    }

    // MARK: - Private Methods

    private func configureUI() {
        layer.cornerRadius = 12
        backgroundColor = #colorLiteral(red: 0.9725490212, green: 0.9725490212, blue: 0.9725490212, alpha: 1)
        layer.cornerCurve = .continuous
        addSubviews(label, imageView)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: label, imageView)

        [
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: imageView.leadingAnchor, constant: 20),

            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.25),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ].activate()
    }
}
