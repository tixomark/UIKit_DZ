// UserProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Vaka
/// Экран профиля пользователя
final class UserProfileViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Профиль"
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        title = Constants.titleText
        view.backgroundColor = .systemBackground
    }
}
