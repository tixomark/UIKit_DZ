// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Main screen view
final class MainViewController: UIViewController {
    // MARK: - Constants

    let startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .customLightGreen
        button.setTitle("Начать", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        return button
    }()

    // MARK: - Private Properties

    private var wordReverter = ReverterModel()
    private var enterYourWordAlertOkAktion: UIAlertAction?

    // MARK: - Life Cycle

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

    // MARK: - Private Methods

    private func setUpUI() {
        view.backgroundColor = .systemBackground

        startButton.addTarget(self, action: #selector(didTapStartButton(_:)), for: .touchUpInside)
        view.addSubview(startButton)
    }

    private func showEnterYourWordAlert() {
        let alert = UIAlertController(
            title: "Введите ваше слово",
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField { [unowned self] textField in
            textField.placeholder = "Введите слово"
            textField.addTarget(self, action: #selector(textDidChangeIn(_:)), for: .editingChanged)
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        alert.addAction(cancelAction)

        enterYourWordAlertOkAktion = UIAlertAction(title: "Ок", style: .cancel) { [wordReverter] _ in
            wordReverter.updateWord(alert.textFields?.first?.text)
        }
        enterYourWordAlertOkAktion?.isEnabled = false
        if let enterYourWordAlertOkAktion {
            alert.addAction(enterYourWordAlertOkAktion)
        }

        present(alert, animated: true)
    }

    @objc private func didTapStartButton(_ sender: UIButton) {
        showEnterYourWordAlert()
    }

    @objc private func textDidChangeIn(_ sender: UITextField) {
        guard let text = sender.text, text.count > 1 else {
            enterYourWordAlertOkAktion?.isEnabled = false
            return
        }
        print(text)
        enterYourWordAlertOkAktion?.isEnabled = true
    }
}
