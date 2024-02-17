// CatalogueViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// tixomark
/// Экран содержащий каталог товаров магазина
final class CatalogueViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Каталог"
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
