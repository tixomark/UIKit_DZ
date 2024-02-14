// BagViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// tixomark
/// Экран корзины пользователя
final class BagViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Корзина"
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
