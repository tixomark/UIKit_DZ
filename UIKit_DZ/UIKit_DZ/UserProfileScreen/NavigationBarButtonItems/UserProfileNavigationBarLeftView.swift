// UserProfileNavigationBarLeftView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Верхний левый элемент навигейшн бара UserProfileViewController
final class UserProfileNavigationBarLeftView: UIView {
    // MARK: - Visual Components

    private let lockImageView: UIImageView = {
        let view = UIImageView()
        view.image = .lockIcon.withTintColor(.accent)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = .verdanaBold?.withSize(18)
        label.textAlignment = .left
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

    func configure(with nickname: String) {
        nicknameLabel.text = nickname
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(lockImageView, nicknameLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: lockImageView, nicknameLabel)
        configureLockImageViewLayout()
        configureNicknameLabelLayout()
    }

    private func configureLockImageViewLayout() {
        [
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -2),
            lockImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            lockImageView.heightAnchor.constraint(equalToConstant: 18),
            lockImageView.widthAnchor.constraint(equalToConstant: 16)
        ].activate()
    }

    private func configureNicknameLabelLayout() {
        [
            nicknameLabel.leadingAnchor.constraint(equalTo: lockImageView.trailingAnchor, constant: 6),
            nicknameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ].activate()
    }
}
