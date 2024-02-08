// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Main screen view
final class MainViewController: UIViewController {
    let startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .customLightGreen
        button.setTitle("Начать", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let startButtonSize = CGSize(width: view.bounds.width - 40, height: 44)
        let startButtonOrigin = CGPoint(
            x: view.bounds.midX - startButtonSize.width / 2,
            y: view.bounds.midY - startButtonSize.height / 2
        )
        startButton.frame = CGRect(origin: startButtonOrigin, size: startButtonSize)
    }

    private func setUpUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(startButton)
    }
}
