// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Authentication screen view
class AuthViewController: UIViewController {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var hidePasswordButton: UIButton!
    @IBOutlet var logInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }

    private func setUpUI() {
        logInButton.layer.cornerRadius = 12
    }

    @IBAction func didTapHidePasswordButton(_ sender: UIButton) {}

    @IBAction func didTapLogInButton(_ sender: UIButton) {}
}
