// RMLinkTabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таббар всея приложения
final class RMLinkTabBarController: UITabBarController {
    // MARK: - Constants

    private enum Constants {
        static let titles = ["Лента", "Уведомления", "Профиль"]
        static let images: [UIImage] = [.homeIcon, .notificationIcon, .userIcon]
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureBarButtonItems()
    }

    // MARK: - Private Methods

    private func configure() {
        let dataProvider = DataProvider()
        let controllers: [UIViewController] = [
            FeedViewController(dataProvider: dataProvider),
            NotificationsViewController(dataProvider: dataProvider),
            UserProfileViewController(dataProvider: dataProvider)
        ]
        let embededControllers = controllers.map { UINavigationController(rootViewController: $0) }
        setViewControllers(embededControllers, animated: false)

        tabBar.unselectedItemTintColor = .accent
        tabBar.backgroundColor = .systemBackground
        tabBar.layer.shadowOffset.height = -1
        tabBar.layer.shadowRadius = 1
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowColor = UIColor.opaqueSeparator.cgColor
    }

    private func configureBarButtonItems() {
        guard let viewControllers else { return }
        for (index, controller) in viewControllers.enumerated() {
            let tabBarItem = UITabBarItem(
                title: Constants.titles[index],
                image: Constants.images[index],
                tag: index
            )
            controller.tabBarItem = tabBarItem
        }
    }
}
