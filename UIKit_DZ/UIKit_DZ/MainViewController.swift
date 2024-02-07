// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Main screen view
final class MainViewController: UIViewController {
    // MARK: - Private Properties

    let guessNumberButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customPurple
        button.layer.borderColor = UIColor.customPurpleStroke.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 30

        button.setTitle("Угадай число", for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana", size: 20)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .systemBackground
        button.titleEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        button.titleLabel?.numberOfLines = 0
        return button
    }()

    let calculatorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customGreen
        button.layer.borderColor = UIColor.customGreenStroke.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 30
        button.setTitle("Калькулятор", for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana", size: 20)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .systemBackground
        button.titleEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        button.titleLabel?.numberOfLines = 0
        return button
    }()

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
        backgroundLayer.frame = CGRect(
            origin: CGPoint(x: 0, y: view.safeAreaInsets.top),
            size: view.bounds.size
        )
        backgroundLayer.contents = UIImage(.backgroundImage)?.cgImage
        backgroundLayer.contentsGravity = .resizeAspectFill
        view.layer.addSublayer(backgroundLayer)

        guessNumberButton.frame = CGRect(x: 82, y: 301, width: 150, height: 150)
        guessNumberButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)

        calculatorButton.frame = CGRect(x: 132, y: 507, width: 200, height: 200)
        calculatorButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        view.addSubview(guessNumberButton)
        view.addSubview(calculatorButton)
    }

    @objc private func didTapButton(_ sender: UIButton) {
        switch sender {
        case guessNumberButton:
            print("guessNumberButton tapped")
        case calculatorButton:
            print("calculatorButton tapped")
        default:
            break
        }
    }
}
