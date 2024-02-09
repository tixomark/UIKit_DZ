// ThanksViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран который говорит спасибо и показывает сообщение, что чек отправлен на почту пользователя
final class ThanksViewController: UIViewController {
    //MARK: - Constants
    
    private enum Constants {
        static let sentToEmailText = "Электронный чек отправили Вам на почту "
    }
    
    // MARK: - IBOutlets

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var exitButton: UIButton!

    // MARK: - Public Properties

    var user: User?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.layer.cornerRadius = 12
        if let login = user?.login {
            titleLabel.text = Constants.sentToEmailText + login
        }
    }

    // MARK: - IBAction

    @IBAction private func dismissThanksVIew(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
