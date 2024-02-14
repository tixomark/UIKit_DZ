// MenuViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// tixomark
/// Основной экран с выбором позиции из пердставленного меню
final class MenuViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "КофеиновЪ"
        static let greetingText = "Добро пожаловать,\n"
        static let menuTitleText = "Минью"
        static let menuItems = [
            (name: "Пти пате аля «РюсЪ»", image: UIImage(.pie)),
            (name: "Горячiя напитки", image: UIImage(.cup)),
            (name: "Кофий", image: UIImage(.coffee))
        ]
        static let interMenuItemSpacing = 20
        static let insetFromTopOfTheScreen = 44
        static let insetFromTopOfBackgroundView = 216
    }

    // MARK: - Visual Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 175, height: 76)
        label.frame.origin = CGPoint(x: 100, y: 5 + Constants.insetFromTopOfTheScreen)

        label.textColor = .menuTitle
        label.font = .amaticSCBold?.withSize(55)
        label.textAlignment = .center
        label.text = Constants.titleText
        return label
    }()

    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 185, height: 44)
        label.frame.origin = CGPoint(x: 20, y: 103 + Constants.insetFromTopOfTheScreen)

        label.textColor = .white.withAlphaComponent(0.8)
        label.font = .verdanaBold?.withSize(16)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = Constants.greetingText
        return label
    }()

    private let userIconLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 44, height: 44)
        label.frame.origin = CGPoint(x: 311, y: 103 + Constants.insetFromTopOfTheScreen)
        label.layer.cornerRadius = 22
        label.layer.masksToBounds = true
        label.backgroundColor = .torquoiseAccent

        label.textColor = .white
        label.font = .verdanaBold?.withSize(16)
        label.textAlignment = .center
        return label
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: 375, height: 564)
        view.frame.origin = CGPoint(x: 0, y: 204 + Constants.insetFromTopOfTheScreen)
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    private let locationMessageView: LocationView = {
        let view = LocationView()
        view.frame.size = CGSize(width: 335, height: 70)
        view.frame.origin = CGPoint(x: 20, y: 40)
        return view
    }()

    private let menuLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 125, height: 40)
        label.frame.origin = CGPoint(x: 125, y: 122)

        label.textColor = .black
        label.font = .amaticSCBold?.withSize(25)
        label.textAlignment = .center
        label.text = Constants.menuTitleText
        return label
    }()

    private let menuLabelFooterView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 100, height: 40)
        view.frame.origin = CGPoint(x: 137, y: 162)
        view.image = UIImage(.footer)
        view.contentMode = .scaleAspectFit
        return view
    }()

    // MARK: - Private Properties
    
    private var menuItemViews: [MenuItemView] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public Methods

    func setUserName(_ username: String) {
        greetingLabel.text = Constants.greetingText + username
        userIconLabel.text = username.first?.uppercased()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .brown

        backgroundView.addSubviews(locationMessageView, menuLabel, menuLabelFooterView)
        view.addSubviews(titleLabel, greetingLabel, userIconLabel, backgroundView)

        // Расставлят и кофигурирует элементы меню
        let menuItemSize = CGSize(width: 335, height: 80)
        for (index, itemData) in Constants.menuItems.enumerated() {
            let view = MenuItemView()
            backgroundView.addSubview(view)
            menuItemViews.append(view)
            view.frame.size = menuItemSize
            let viewOriginY = Constants
                .insetFromTopOfBackgroundView + (Int(menuItemSize.height) + Constants.interMenuItemSpacing) * index
            view.frame.origin = CGPoint(x: 20, y: viewOriginY)
            view.configure(with: itemData)
        }

        let menuItemTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenuItem(_:)))
        menuItemViews[2].addGestureRecognizer(menuItemTapGesture)
    }

    @objc private func didTapMenuItem(_ sender: UITapGestureRecognizer) {
        let menuItemCofigurationVC = MenuItemCofigurationViewController()
        navigationController?.pushViewController(menuItemCofigurationVC, animated: true)
    }
}
