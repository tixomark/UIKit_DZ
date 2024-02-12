// MenuViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// tixomark
/// Основной экран с выбором позиции из пердставленного меню
final class MenuViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let title = "КофеиновЪ"
        static let greeting = "Добро пожаловать,\n"
        static let menuTitle = "Минью"
        static let menuItems = [
            (name: "Пти пате аля «РюсЪ»", image: UIImage(.pie)),
            (name: "Горячiя напитки", image: UIImage(.cup)),
            (name: "Кофий", image: UIImage(.coffee))
        ]
    }

    // MARK: - Private Properties

    /// Отображает заголовок экрана
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 175, height: 76)
        label.frame.origin = CGPoint(x: 100, y: 5 + 44)

        label.textColor = .menuTitle
        label.font = UIFont(name: "AmaticSC-Bold", size: 55)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = Constants.title
        return label
    }()

    /// Содержит приветствие пользователю
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 185, height: 44)
        label.frame.origin = CGPoint(x: 20, y: 103 + 44)

        label.textColor = .white.withAlphaComponent(0.8)
        label.font = UIFont(name: "Verdana-Bold", size: 16)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = Constants.greeting
        return label
    }()

    /// Иконка пользователя справа от приветствия
    private let userIcon: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 44, height: 44)
        label.frame.origin = CGPoint(x: 311, y: 103 + 44)
        label.layer.cornerRadius = 22
        label.layer.masksToBounds = true
        label.backgroundColor = .torquoiseAccent

        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 16)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    /// Белая подложка
    private let backgroundView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: 375, height: 564)
        view.frame.origin = CGPoint(x: 0, y: 204 + 44)
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    /// Сообщение с просьбой о доступе к геолокации
    private let locationMessageView: LocationView = {
        let view = LocationView()
        view.frame.size = CGSize(width: 335, height: 70)
        view.frame.origin = CGPoint(x: 20, y: 40)
        return view
    }()

    /// Заголовок меню
    private let menuLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 125, height: 40)
        label.frame.origin = CGPoint(x: 125, y: 122)

        label.textColor = .black
        label.font = UIFont(name: "AmaticSC-Bold", size: 25)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = Constants.menuTitle
        return label
    }()

    /// Футер заголовка меню (завитушки)
    private let menuLabelFooterView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 100, height: 40)
        view.frame.origin = CGPoint(x: 137, y: 162)
        view.image = UIImage(.footer)
        view.contentMode = .scaleAspectFit
        return view
    }()

    /// Содержит сыылки на все элементы меню данного экрана
    private var menuItemViews: [MenuItemView] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: - Public Methods

    /// Устанавливает имя пользователя для данного экрана
    func setUserName(_ username: String) {
        greetingLabel.text = Constants.greeting + username
        userIcon.text = username.first?.uppercased()
    }

    // MARK: - Private Methods

    private func setUpUI() {
        view.backgroundColor = .brown

        backgroundView.addSubviews(locationMessageView, menuLabel, menuLabelFooterView)
        view.addSubviews(titleLabel, greetingLabel, userIcon, backgroundView)

        /// Расставляю и кофигурирую элементы меню
        let menuItemSize = CGSize(width: 335, height: 80)
        for (index, itemData) in Constants.menuItems.enumerated() {
            let view = MenuItemView()
            backgroundView.addSubview(view)
            menuItemViews.append(view)
            view.frame.size = menuItemSize
            view.frame.origin = CGPoint(x: 20, y: 216 + (Int(menuItemSize.height) + 20) * index)
            view.configureUsing(itemData)
        }

        let menuItemTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenuItem(_:)))
        menuItemViews[2].addGestureRecognizer(menuItemTapGesture)
    }

    /// Отрабатывает назатия ползователя на элементы меню
    @objc private func didTapMenuItem(_ sender: UITapGestureRecognizer) {
        let menuItemCofigurationVC = MenuItemCofigurationViewController()
        navigationController?.pushViewController(menuItemCofigurationVC, animated: true)
    }
}
