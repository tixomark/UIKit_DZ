// UserPofileCellBodyView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Основная часть профиля пользователя
final class UserProfileCellBodyView: UIView {
    private enum Constants {
        static let publicationsText = "публикации"
        static let subscribersText = "подписчики"
        static let subscriptionsText = "подписки"
    }

    // MARK: - Visual Components

    private let userIconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        return view
    }()

    private let addImageView: UIImageView = {
        let view = UIImageView()
        view.image = .plusIcon.withTintColor(.systemBackground)
        view.contentMode = .center
        view.layer.cornerRadius = 13
        view.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.2745098039, blue: 0.368627451, alpha: 1)
        return view
    }()

    private let publicationsAmountView: AmountView = {
        let view = AmountView()
        view.setCaption(Constants.publicationsText)
        return view
    }()

    private let subscribersAmountView: AmountView = {
        let view = AmountView()
        view.setCaption(Constants.subscribersText)
        return view
    }()

    private let subscriptionsAmountView: AmountView = {
        let view = AmountView()
        view.setCaption(Constants.subscriptionsText)
        return view
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = .verdanaBold?.withSize(14)
        label.textAlignment = .left
        return label
    }()

    private let occupationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = .verdana?.withSize(14)
        label.textAlignment = .left
        return label
    }()

    private let linkImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = .paperClipIcon.withRenderingMode(.alwaysOriginal)
        return view
    }()

    private lazy var linkButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .verdana?.withSize(14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    var tapLinkButtonHandler: (() -> ())?

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

    func configure(with user: CurrentUser) {
        userIconImageView.image = UIImage(user.profileImageName)
        usernameLabel.text = user.username
        occupationLabel.text = user.occupation
        linkButton.setTitle(user.link, for: .normal)
        publicationsAmountView.setAmount(user.publicationsAmount)
        subscribersAmountView.setAmount(user.subscribersAmount)
        subscriptionsAmountView.setAmount(user.subscriptionsAmount)
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(userIconImageView, addImageView, publicationsAmountView, subscribersAmountView)
        addSubviews(subscriptionsAmountView, usernameLabel, occupationLabel, linkImageView, linkButton)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: userIconImageView, addImageView, publicationsAmountView, subscribersAmountView)
        UIView.doNotTAMIC(for: subscriptionsAmountView, usernameLabel, occupationLabel, linkImageView, linkButton)
        configureUserIconImageViewLayout()
        configureAddImageViewLayout()
        configurePublicationsAmountViewLayout()
        configureSubscribersAmountViewLayout()
        configureSubscriptionsAmountViewLayout()
        configureUsernameLabelLayout()
        configureOccupationLabelLayout()
        configureLinkImageViewLayout()
        configureLinkButtonLayout()
    }

    private func configureUserIconImageViewLayout() {
        [
            userIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            userIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            userIconImageView.heightAnchor.constraint(equalToConstant: 80),
            userIconImageView.widthAnchor.constraint(equalTo: userIconImageView.heightAnchor)
        ].activate()
    }

    private func configureAddImageViewLayout() {
        [
            addImageView.trailingAnchor.constraint(equalTo: userIconImageView.trailingAnchor),
            addImageView.bottomAnchor.constraint(equalTo: userIconImageView.bottomAnchor),
            addImageView.heightAnchor.constraint(equalToConstant: 26),
            addImageView.widthAnchor.constraint(equalTo: addImageView.heightAnchor)
        ].activate()
    }

    private func configurePublicationsAmountViewLayout() {
        [
            publicationsAmountView.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            publicationsAmountView.trailingAnchor.constraint(equalTo: subscribersAmountView.leadingAnchor)
        ].activate()
    }

    private func configureSubscribersAmountViewLayout() {
        [
            subscribersAmountView.topAnchor.constraint(equalTo: publicationsAmountView.topAnchor),
            subscribersAmountView.trailingAnchor.constraint(equalTo: subscriptionsAmountView.leadingAnchor)
        ].activate()
    }

    private func configureSubscriptionsAmountViewLayout() {
        [
            subscriptionsAmountView.topAnchor.constraint(equalTo: publicationsAmountView.topAnchor),
            subscriptionsAmountView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23)
        ].activate()
    }

    private func configureUsernameLabelLayout() {
        [
            usernameLabel.topAnchor.constraint(equalTo: userIconImageView.bottomAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ].activate()
    }

    private func configureOccupationLabelLayout() {
        [
            occupationLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 11),
            occupationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ].activate()
    }

    private func configureLinkImageViewLayout() {
        [
            linkImageView.topAnchor.constraint(equalTo: occupationLabel.bottomAnchor, constant: 6),
            linkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            linkImageView.widthAnchor.constraint(equalToConstant: 17),
            linkImageView.heightAnchor.constraint(equalTo: linkImageView.widthAnchor)
        ].activate()
    }

    private func configureLinkButtonLayout() {
        [
            linkButton.topAnchor.constraint(equalTo: occupationLabel.bottomAnchor, constant: 6),
            linkButton.leadingAnchor.constraint(equalTo: linkImageView.trailingAnchor, constant: 2),
            linkButton.heightAnchor.constraint(equalTo: linkImageView.heightAnchor),
            linkButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ].activate()
    }

    @objc private func linkButtonTapped() {
        tapLinkButtonHandler?()
    }
}
