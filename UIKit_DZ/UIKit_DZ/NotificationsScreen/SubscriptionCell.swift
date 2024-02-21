// SubscriptionCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка использующаяся для отображения сведений о подписках пользователей
final class SubscriptionCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let subscribedText = "Вы подписаны"
        static let notSubscribedText = "Подписаться"
    }

    // MARK: - Visual Components

    private let userImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.textAlignment = .left
        label.font = .verdana?.withSize(12)
        label.numberOfLines = 0
        return label
    }()

    private lazy var subscribtionButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .verdanaBold?.withSize(10)
        button.layer.borderColor = UIColor.opaqueSeparator.cgColor
        button.addTarget(self, action: #selector(subscriptionButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Private Properties

    private var isSubscribed: Bool = false {
        didSet {
            switchSubscriptionButtonTo(isSubscribed)
        }
    }

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

    // MARK: - Public Methods

    func configure(with subscription: Subscription) {
        userImageView.image = UIImage(subscription.user.profileImage)
        switchSubscriptionButtonTo(subscription.isSubscribed)

        let infoText = subscription.user.nickname.attributed()
            .withColor(.accent)
            .withFont(.verdanaBold?.withSize(12))
        infoText.append(
            subscription.text.attributed()
                .withColor(.accent)
                .withFont(.verdana?.withSize(12))
        )
        infoLabel.attributedText = infoText
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubviews(userImageView, infoLabel, subscribtionButton)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: userImageView, infoLabel, subscribtionButton)
        [
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor),
            userImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 7),
            infoLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            subscribtionButton.centerYAnchor.constraint(equalTo: infoLabel.centerYAnchor),
            subscribtionButton.leadingAnchor.constraint(equalTo: infoLabel.trailingAnchor, constant: 10),
            subscribtionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            subscribtionButton.heightAnchor.constraint(equalToConstant: 30),
            subscribtionButton.widthAnchor.constraint(equalToConstant: 140)
        ].activate()
    }

    private func switchSubscriptionButtonTo(_ isActivated: Bool) {
        if isActivated {
            subscribtionButton.setTitle(Constants.subscribedText, for: .normal)
            subscribtionButton.setTitleColor(.opaqueSeparator, for: .normal)
            subscribtionButton.layer.borderWidth = 1
            subscribtionButton.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        } else {
            subscribtionButton.setTitle(Constants.notSubscribedText, for: .normal)
            subscribtionButton.setTitleColor(.white, for: .normal)
            subscribtionButton.layer.borderWidth = 0
            subscribtionButton.backgroundColor = .systemBlue
        }
    }

    @objc private func subscriptionButtonTapped() {
        isSubscribed = !isSubscribed
    }
}
