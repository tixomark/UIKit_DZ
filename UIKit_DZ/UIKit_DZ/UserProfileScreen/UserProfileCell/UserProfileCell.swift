// UserProfileCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Отображает профиль авторизированного пользователя
final class UserProfileCell: UITableViewCell {
    // MARK: - Visual Components

    private let profileBodyView = UserProfileCellBodyView()
    private let profileFooterView = UserProfileCellFooterView()

    // MARK: - Public Properties

    var tapLinkButtonHandler: (() -> ())?

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    func configure(with user: CurrentUser) {
        profileBodyView.configure(with: user)
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubviews(profileBodyView, profileFooterView)
        profileBodyView.tapLinkButtonHandler = { [unowned self] in
            tapLinkButtonHandler?()
        }
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: profileBodyView, profileFooterView)
        configureProfileBodyViewLayout()
        configureProfileFooterViewLayout()
    }

    private func configureProfileBodyViewLayout() {
        [
            profileBodyView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileBodyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileBodyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ].activate()
    }

    private func configureProfileFooterViewLayout() {
        [
            profileFooterView.topAnchor.constraint(equalTo: profileBodyView.bottomAnchor),
            profileFooterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileFooterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileFooterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].activate()
    }
}
