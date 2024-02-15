// ShoeStoreTabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таббар всея приложения
final class ShoeStoreTabBarController: UITabBarController {
    // MARK: - Constants

    private enum Constants {
        static let titles = ["Каталог", "Корзина", "Профиль"]
        static let images: [UIImage] = [.catalogueIcon, .bagIcon, .profileIcon]
        static let selectedImages: [UIImage] = [
            .catalogueSelectedIcon.withRenderingMode(.alwaysOriginal),
            .bagSelectedIcon.withRenderingMode(.alwaysOriginal),
            .profileSelectedIcon.withRenderingMode(.alwaysOriginal)
        ]
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureBarButtonItems()
    }

    // MARK: - Private Methods

    private func configure() {
        tabBar.tintColor = .accentPink
        tabBar.unselectedItemTintColor = .black
        let controllers: [UIViewController] = [
            UINavigationController(rootViewController: CatalogueViewController()),
            UINavigationController(rootViewController: BagViewController()),
            UINavigationController(rootViewController: UserProfileViewController())
        ]
        setViewControllers(controllers, animated: true)
    }

    private func configureBarButtonItems() {
        guard let viewControllers else { return }
        for index in viewControllers.indices {
            let tabBarItem = UITabBarItem(
                title: Constants.titles[index],
                image: Constants.images[index],
                selectedImage: Constants.selectedImages[index]
            )
            self.viewControllers?[index].tabBarItem = tabBarItem
        }
    }
}
