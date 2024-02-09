// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран отвечающий за аутентификацию пльзователя
final class AuthViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let goToDetailsVCSegueID = "goToDatailsSegue"
    }

    // MARK: - IBOutlets

    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var hidePasswordButton: UIButton!
    @IBOutlet private var logInButton: UIButton!

    // MARK: - Public Properties

    /// Модель обрабатывающая данные пользователя
    private var user = User()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        user.validationResultReceiver = self
    }

    // MARK: - Public Methods

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        passwordTextField.resignFirstResponder()
        loginTextField.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.goToDetailsVCSegueID {
            let reserveVC = segue.destination as? ReserveTableViewController
            reserveVC?.user = user
        }
    }

    // MARK: - Private Methods

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

    /// Переключает доступность нажатия кнопки входа
    private func switchLogInButtonStateTo(_ isEnabled: Bool) {
        logInButton.isEnabled = isEnabled
        logInButton.alpha = logInButton.isEnabled ? 1 : 0.5
    }

    /// Обноляет пользовательския данные в модели исходя из вводимого текста
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

    /// Обрабатывает назатия на кнопку скрытия пароля
    @IBAction private func hidePasswordButtonTapped(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let icon = passwordTextField.isSecureTextEntry ? UIImage(.hidenIcon) : UIImage(.shownIcon)
        hidePasswordButton.setImage(icon, for: .normal)
    }
}

extension AuthViewController: UserFieldsValidationResultReceiver {
    /// Обрабатывает результаты валидации пользовательских данных из модели
    func loginAndPaswordValidationChangedTo(_ doesConform: Bool) {
        switchLogInButtonStateTo(doesConform)
    }
}

extension AuthViewController: UITextFieldDelegate {
    /// Управляет фокусировкой, когда надо изменить фокус и когда убрать.
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
