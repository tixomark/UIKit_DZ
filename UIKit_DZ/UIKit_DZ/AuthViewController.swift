// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Authentication screen view
class AuthViewController: UIViewController {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var hidePasswordButton: UIButton!
    @IBOutlet var logInButton: UIButton!

    var user = UserModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        user.validationResultReceiver = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        passwordTextField.resignFirstResponder()
        loginTextField.resignFirstResponder()
    }

    private func setUpUI() {
        logInButton.layer.cornerRadius = 12
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = .done
        passwordTextField.delegate = self
        loginTextField.delegate = self
        switchLogInButtonStateTo(false)

        loginTextField.addTarget(self, action: #selector(textDidChangeIn(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChangeIn(_:)), for: .editingChanged)
    }

    private func switchLogInButtonStateTo(_ isEnabled: Bool) {
        logInButton.isEnabled = isEnabled
        logInButton.alpha = logInButton.isEnabled ? 1 : 0.5
    }

    @objc private func textDidChangeIn(_ sender: UITextField) {
        switch sender {
        case loginTextField:
            user.login = sender.text
        case passwordTextField:
            user.password = sender.text
        default:
            break
        }
    }

    @IBAction func didTapHidePasswordButton(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let icon = passwordTextField.isSecureTextEntry ? UIImage(.hidenIcon) : UIImage(.shownIcon)
        hidePasswordButton.setImage(icon, for: .normal)
    }

    @IBAction func didTapLogInButton(_ sender: UIButton) {}
}

extension AuthViewController: UserFieldsValidationResultReceiver {
    func loginAndPaswordValidationChangedTo(_ doesConform: Bool) {
        switchLogInButtonStateTo(doesConform)
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
