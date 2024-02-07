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
        let backgroundLayer = CALayer()
        backgroundLayer.frame = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: view.bounds.size
        )
        let backgrounImage = UIImage(named: "backgroundImage")
        backgroundLayer.contentsGravity = .resizeAspectFill
        backgroundLayer.contents = backgrounImage?.cgImage

        view.layer.addSublayer(backgroundLayer)
    }
}
