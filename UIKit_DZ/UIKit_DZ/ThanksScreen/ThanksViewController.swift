// ThanksViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// View that shows thanks message after user payed the bill
class ThanksViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var exitButton: UIButton!

    // MARK: - Public Properties

    var user: UserModel?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.layer.cornerRadius = 12
        if let login = user?.login {
            titleLabel.text = "Электронный чек отправили Вам на почту " + login
        }
    }

    // MARK: - Public Methods

    @IBAction func dismissThanksVIew(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
