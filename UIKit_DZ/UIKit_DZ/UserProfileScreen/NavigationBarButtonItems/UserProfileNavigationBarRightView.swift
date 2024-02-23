// UserProfileNavigationBarRightView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Верхний правый элемент навигейшн бара UserProfileViewController
final class UserProfileNavigationBarRightView: UIView {
    // MARK: - Visual Components

    private let plusImageView: UIImageView = {
        let view = UIImageView()
        view.image = .addIcon.withTintColor(.accent)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let menuImageView: UIImageView = {
        let view = UIImageView()
        view.image = .menuIcon.withTintColor(.accent)
        view.contentMode = .scaleAspectFit
        return view
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
        addSubviews(plusImageView, menuImageView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: plusImageView, menuImageView)
        configurePlusImageViewLayout()
        configureMenuImageViewLayout()
    }

    private func configurePlusImageViewLayout() {
        [
            plusImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusImageView.heightAnchor.constraint(equalToConstant: 16),
            plusImageView.widthAnchor.constraint(equalToConstant: 18)
        ].activate()
    }

    private func configureMenuImageViewLayout() {
        [
            menuImageView.leadingAnchor.constraint(equalTo: plusImageView.trailingAnchor, constant: 11),
            menuImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            menuImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            menuImageView.heightAnchor.constraint(equalToConstant: 10),
            menuImageView.widthAnchor.constraint(equalToConstant: 14)
        ].activate()
    }
}
