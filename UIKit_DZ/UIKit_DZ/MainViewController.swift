// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Main screen view
final class MainViewController: UIViewController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }

    // MARK: - Private Methods

    private func setUpUI() {
        view.backgroundColor = .systemBackground

        // set up background image
        let backgroundLayer = CALayer()
        backgroundLayer.frame = CGRect(origin: .zero, size: view.bounds.size)
        backgroundLayer.contents = UIImage(.backgroundImage)?.cgImage
        backgroundLayer.contentsGravity = .resizeAspectFill
        view.layer.addSublayer(backgroundLayer)
    }
}
