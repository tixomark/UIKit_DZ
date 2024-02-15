// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран приложения с авторизацией
final class AuthViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let authLabelName = "Авторизация"
        static let loginLabelName = "Логин"
        static let passwordLabelName = "Пароль"
        static let loginTextFieldName = "Введите почту"
        static let passwordTextFieldName = "Введите пароль"
        static let singUpButtonTitle = "Войти"
        static let nameCafeImage = "piconLabel"
    }

    // MARK: - Visual Components

    private lazy var nameCafeLabel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.nameCafeImage)
        image.frame = CGRect(x: 100, y: 103, width: 175, height: 76)
        return image
    }()

    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 248, width: self.view.frame.width, height: 564)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()

    private var authLabel = UILabel()
    private var loginLabel = UILabel()
    private var passwordLabel = UILabel()
    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    private var showPasswordButton = UIButton()
    private var sigUpButton = SubmissionButton()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .brown
        view.addSubview(nameCafeLabel)
        view.addSubview(whiteView)
        view.addSubview(makeDividerView(lineY: 386))
        view.addSubview(makeDividerView(lineY: 462))
        makeLabel(label: authLabel, lineY: 35, title: Constants.authLabelName, fontSize: 26)
        makeLabel(label: loginLabel, lineY: 84, title: Constants.loginLabelName)
        makeLabel(label: passwordLabel, lineY: 159, title: Constants.passwordLabelName)
        makeTextFields(
            textField: loginTextField,
            placeholder: Constants.loginTextFieldName,
            lineY: 113,
            isSecure: false
        )
        makeTextFields(textField: passwordTextField, placeholder: Constants.passwordTextFieldName, lineY: 188)
        makeShowPasswordButton()
        makeSignUpButton()
    }

    private func makeLabel(label: UILabel, lineY: Int, title: String, fontSize: CGFloat = 16) {
        label.frame = CGRect(x: 16, y: lineY, width: 195, height: 31)
        label.text = title
        label.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        whiteView.addSubview(label)
    }

    private func makeDividerView(lineY: Int) -> UIView {
        let divider = UIView()
        divider.backgroundColor = .gray
        divider.frame = CGRect(x: 16, y: lineY, width: 335, height: 1)
        return divider
    }

    private func makeTextFields(
        textField: UITextField, placeholder: String, lineY: Int, isSecure: Bool = false
    ) {
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.isSecureTextEntry = isSecure
        textField.frame = CGRect(x: 16, y: lineY, width: 175, height: 20)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingChanged)
        whiteView.addSubview(textField)
    }

    private func makeShowPasswordButton() {
        showPasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        showPasswordButton.frame = CGRect(x: 332, y: 185, width: 22, height: 19)
        showPasswordButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        showPasswordButton.tintColor = .gray
        whiteView.addSubview(showPasswordButton)
    }

    private func makeSignUpButton() {
        sigUpButton.center.x = view.center.x
        sigUpButton.backgroundColor = #colorLiteral(red: 0.80188936, green: 0.9210196137, blue: 0.9322513938, alpha: 1)
        sigUpButton.setTitle(Constants.singUpButtonTitle, for: .normal)
        sigUpButton.isEnabled = false
        sigUpButton.addTarget(self, action: #selector(presentMenuViewController), for: .touchUpInside)
        view.addSubview(sigUpButton)
    }

    @objc private func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
        showPasswordButton.setImage(
            UIImage(systemName: !passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"),
            for: .normal
        )
    }

    @objc private func presentMenuViewController() {
        let menuVC = MenuViewController()
        let navigationVC = UINavigationController(rootViewController: menuVC)
        navigationVC.modalPresentationStyle = .fullScreen
        menuVC.setUserName(loginTextField.text ?? "")
        present(navigationVC, animated: true)
    }
}

/// Расширение( UITextFieldDelegate )
extension AuthViewController: UITextFieldDelegate {
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        let textPassword = passwordTextField.text ?? ""
        let textLogIn = loginTextField.text ?? ""
        if !textPassword.isEmpty, !textLogIn.isEmpty {
            sigUpButton.backgroundColor = .enabled
            sigUpButton.isEnabled = true
        } else {
            sigUpButton.backgroundColor = .disable
            sigUpButton.isEnabled = false
        }
    }
}
