// UserProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit


/// Экран профиля пользователя
final class UserProfileViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Профиль"
        static let personalDataTitle = "Личные данные"
        static let discountTitle = "15%"
        static let numberCardTitle = "1000 0001 0102"
        static let personCellTitle = "Мои данные"
        static let bringFriend = "Приведи друга"
        static let feedBack = "Обратная связь"
        static let cardIconImage: UIImage = .logoCard
        static let qRCodImage: UIImage = .qrCod
        static let infoImage: UIImage = .info
        static let personCellIcon: UIImage = .personIcon
        static let bringFriendIcon: UIImage = .friendIcon
        static let feedBackIcon: UIImage = .feedBackIcon
    }

    // MARK: - Visual Components

    private let cardView: UIView = {
        let card = UIView()
        card.backgroundColor = .black
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 20
        card.dropShadow()
        return card
    }()

    private var cardIconImage: UIImageView = {
        let image = UIImageView()
        image.image = Constants.cardIconImage
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var backgroundCirculQRCodView = UIView()
    private var backgroundCirculInfoView = UIView()
    private var iconQRCodImageView = UIImageView()
    private var iconInfoImageView = UIImageView()
    private var discountLabel = UILabel()
    private var numberCardLabel = UILabel()
    private var personalLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = Constants.personalDataTitle
        title.font = .verdanaBold?.withSize(16)
        return title
    }()

    private var myDataCell = PersonalCell()
    private var bringFriendCell = PersonalCell()
    private var feedBaccCell = PersonalCell()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Private Methods

    private func configure() {
        title = Constants.titleText
        view.backgroundColor = .systemBackground
        view.addSubview(cardView)
        view.addSubview(cardIconImage)
        view.addSubview(personalLabel)
        view.addSubview(myDataCell)
        configureCardView()
        makeCell(cell: myDataCell, title: Constants.personCellTitle, icon: Constants.personCellIcon)
        makeCell(cell: bringFriendCell, title: Constants.bringFriend, icon: Constants.bringFriendIcon)
        makeCell(cell: feedBaccCell, title: Constants.feedBack, icon: Constants.feedBackIcon)
        makeConstraint()
    }

    private func makeLabelCard(label: UILabel, title: String, sizeFont: CGFloat, fontBold: Bool = false) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = fontBold ? .verdanaBold?.withSize(sizeFont) : .verdana?.withSize(sizeFont)
        label.textColor = .white
        cardView.addSubview(label)
    }

    private func configureCardView() {
        makeLabelCard(label: discountLabel, title: Constants.discountTitle, sizeFont: 16)
        makeLabelCard(label: numberCardLabel, title: Constants.numberCardTitle, sizeFont: 14)
        makeBackgroundCirculView(
            view: backgroundCirculQRCodView,
            iconImageView: iconQRCodImageView,
            icon: Constants.qRCodImage
        )
        makeBackgroundCirculView(
            view: backgroundCirculInfoView,
            iconImageView: iconInfoImageView,
            icon: Constants.infoImage
        )
    }

    private func makeBackgroundCirculView(view: UIView, iconImageView: UIImageView, icon: UIImage) {
        iconImageView.frame.size = CGSize(width: 15, height: 15)
        iconImageView.image = icon
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 15
        cardView.addSubview(view)
        view.addSubview(iconImageView)
    }

    private func makeCell(cell: PersonalCell, title: String, icon: UIImage) {
        cell.titleCellLabel.text = title
        cell.iconCell.image = icon
        cell.translatesAutoresizingMaskIntoConstraints = false
        let actionTap = UITapGestureRecognizer(target: self, action: #selector(presentPersonalViewController))
        cell.addGestureRecognizer(actionTap)
        view.addSubview(cell)
    }

    private func makeConstraint() {
        makeCardViewAnchor()
        makeCardIconImageAnchor()
        makeDisccountLabelAnchor()
        makeNumberCardLabelAnchor()
        makeBackgroundCirculQRCodViewAnchor()
        makeBackgroundCirculInfoViewAnchor()
        makeIconQRCodImageViewAnchor()
        makeIconInfoImageViewAnchor()
        makePersonalLabelAnchor()
        makemyDataCellAnchor()
        makeBringFriendCellAnchor()
        makeFeedBaccCellAnchor()
    }

    @objc private func presentPersonalViewController() {
        let personalViewController = UserDataViewController()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(personalViewController, animated: true)
    }
}

// MARK: - Setup Anchor

extension UserProfileViewController {
    private func makeCardViewAnchor() {
        cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        cardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 4).isActive = true
    }

    private func makeCardIconImageAnchor() {
        cardIconImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16).isActive = true
        cardIconImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
    }

    private func makeDisccountLabelAnchor() {
        discountLabel.topAnchor.constraint(equalTo: cardIconImage.bottomAnchor, constant: 20).isActive = true
        discountLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 14).isActive = true
    }

    private func makeNumberCardLabelAnchor() {
        numberCardLabel.topAnchor.constraint(equalTo: discountLabel.bottomAnchor, constant: 7).isActive = true
        numberCardLabel.leadingAnchor.constraint(equalTo: discountLabel.leadingAnchor).isActive = true
    }

    private func makeBackgroundCirculQRCodViewAnchor() {
        backgroundCirculQRCodView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 13).isActive = true
        backgroundCirculQRCodView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -13)
            .isActive = true
        backgroundCirculQRCodView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backgroundCirculQRCodView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func makeBackgroundCirculInfoViewAnchor() {
        backgroundCirculInfoView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20).isActive = true
        backgroundCirculInfoView.centerXAnchor.constraint(equalTo: backgroundCirculQRCodView.centerXAnchor)
            .isActive = true
        backgroundCirculInfoView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backgroundCirculInfoView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func makeIconQRCodImageViewAnchor() {
        iconQRCodImageView.centerXAnchor.constraint(equalTo: backgroundCirculQRCodView.centerXAnchor).isActive = true
        iconQRCodImageView.centerYAnchor.constraint(equalTo: backgroundCirculQRCodView.centerYAnchor).isActive = true
    }

    private func makeIconInfoImageViewAnchor() {
        iconInfoImageView.centerXAnchor.constraint(equalTo: backgroundCirculInfoView.centerXAnchor).isActive = true
        iconInfoImageView.centerYAnchor.constraint(equalTo: backgroundCirculInfoView.centerYAnchor).isActive = true
    }

    private func makePersonalLabelAnchor() {
        personalLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 28).isActive = true
        personalLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
    }

    private func makemyDataCellAnchor() {
        myDataCell.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        myDataCell.topAnchor.constraint(equalTo: personalLabel.bottomAnchor, constant: 22).isActive = true
        myDataCell.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        myDataCell.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func makeBringFriendCellAnchor() {
        bringFriendCell.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        bringFriendCell.topAnchor.constraint(equalTo: myDataCell.bottomAnchor, constant: 20).isActive = true
        bringFriendCell.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        bringFriendCell.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func makeFeedBaccCellAnchor() {
        feedBaccCell.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        feedBaccCell.topAnchor.constraint(equalTo: bringFriendCell.bottomAnchor, constant: 20).isActive = true
        feedBaccCell.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        feedBaccCell.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
