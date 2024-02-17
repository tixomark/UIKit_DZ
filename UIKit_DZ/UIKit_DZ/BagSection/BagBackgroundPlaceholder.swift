// BagBackgroundPlaceholder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Плейсхолдер для экрана корзины если она пустая
final class BagBackgroundPlaceholder: UIView {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Ваша корзина пуста"
        static let infoText = "Перейдие в каталог и добавьте\nтовары в корзину"
    }

    // MARK: - Visual Components

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        let imageInsets = UIEdgeInsets(top: 17, left: 19, bottom: 17, right: 19)
        view.image = .bagPlaceholderIcon.resizableImage(withCapInsets: imageInsets, resizingMode: .stretch)
        view.layer.borderColor = #colorLiteral(red: 0.6941176471, green: 0.7058823529, blue: 0.7333333333, alpha: 1)
        view.layer.borderWidth = 1
        view.backgroundColor = .backgroundAccent
        view.layer.cornerRadius = 12
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .verdanaBold?.withSize(16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = Constants.titleText
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .opaqueSeparator
        label.font = .verdana?.withSize(16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = Constants.infoText
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

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .clear
        addSubviews(imageView, titleLabel, infoLabel)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: imageView, titleLabel, infoLabel)
        [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 18),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 44),
            infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].activate()
    }
}
