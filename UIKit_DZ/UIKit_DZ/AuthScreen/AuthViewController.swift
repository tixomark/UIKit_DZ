// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран приложения с авторизацией
final class AuthViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let authLabel = "Авторизация"
        static let loginLabel = "Логин"
        static let passwordLabel = "Пароль"
        static let loginTextField = "Введите почту"
        static let passwordTextField = "Введите пароль"
    }

    // MARK: - Visual Components

    /// лейбл с именем кафе
    private lazy var nameCafeLabel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "piconLabel")
        image.frame = CGRect(x: 100, y: 103, width: 175, height: 76)
        return image
    }()

    /// белая вьюшка нижняя
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 248, width: self.view.frame.width, height: 564)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()

    /// Лейбл авторизации
    private lazy var authLabel = UILabel()
    /// ллейбл логин
    private lazy var loginLabel = UILabel()
    /// лейбл пароля
    private lazy var passwordLabel = UILabel()
    /// текст фиилд с вводом логина
    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    /// кнопка показать скрыть пароль
    private var showPasswordButton = UIButton()
    /// кнопка для перехода на следующую вью
    private var sigUpButton = UniversalButton()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: - Private Methods

    /// заполнение вью элементами
    private func setUpUI() {
        view.backgroundColor = #colorLiteral(red: 0.4704148769, green: 0.3292115331, blue: 0.1944105923, alpha: 1)
        view.addSubview(nameCafeLabel)
        view.addSubview(whiteView)
        view.addSubview(ccreateDividerView(lineY: 386))
        view.addSubview(ccreateDividerView(lineY: 462))
        createLabel(label: authLabel, lineY: 35, title: Constants.authLabel, fontSize: 26)
        createLabel(label: loginLabel, lineY: 84, title: Constants.loginLabel)
        createLabel(label: passwordLabel, lineY: 159, title: Constants.passwordLabel)
        createTextFields(textField: loginTextField, placeholder: Constants.loginTextField, lineY: 113, isSecure: false)
        createTextFields(textField: passwordTextField, placeholder: Constants.passwordTextField, lineY: 188)
        createShowPasswordButton()
        createSignUpButton()
    }

    /// создание загголовков для текстфилда
    private func createLabel(label: UILabel, lineY: Int, title: String, fontSize: CGFloat = 16) {
        label.frame = CGRect(x: 16, y: lineY, width: 195, height: 31)
        label.text = title
        label.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        whiteView.addSubview(label)
    }

    /// разделитель вюшка
    private func ccreateDividerView(lineY: Int) -> UIView {
        let divider = UIView()
        divider.backgroundColor = .gray
        divider.frame = CGRect(x: 16, y: lineY, width: 335, height: 1)
        return divider
    }

    /// создание textFields
    private func createTextFields(
        textField: UITextField, placeholder: String, lineY: Int, isSecure: Bool = false
    ) {
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.isSecureTextEntry = isSecure
        textField.frame = CGRect(x: 16, y: lineY, width: 175, height: 20)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingChanged)
        whiteView.addSubview(textField)
    }

    /// метод для кнопки показывать или сскрывать пароль
    private func createShowPasswordButton() {
        showPasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        showPasswordButton.frame = CGRect(x: 332, y: 185, width: 22, height: 19)
        showPasswordButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        showPasswordButton.tintColor = .gray
        whiteView.addSubview(showPasswordButton)
    }

    /// кнопка присоединиться
    private func createSignUpButton() {
        sigUpButton.center.x = view.center.x
        sigUpButton.backgroundColor = #colorLiteral(red: 0.80188936, green: 0.9210196137, blue: 0.9322513938, alpha: 1)
        sigUpButton.setTitle("Войти", for: .normal)
        sigUpButton.isEnabled = false
        sigUpButton.addTarget(self, action: #selector(presentSecondVC), for: .touchUpInside)
        view.addSubview(sigUpButton)
    }

    /// кнопка показать/скрыть пароль
    @objc private func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
        showPasswordButton.setImage(
            UIImage(systemName: !passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"),
            for: .normal
        )
    }

    /// пушим следующий экран
    @objc private func presentSecondVC() {
        let menuVC = MenuViewController()
        let navigationVC = UINavigationController(rootViewController: menuVC)
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true)
    }
}

/// Расширение
extension AuthViewController: UITextFieldDelegate {
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        let textPassword = passwordTextField.text ?? ""
        let textLogIn = loginTextField.text ?? ""
        if !textPassword.isEmpty, !textLogIn.isEmpty {
            sigUpButton.backgroundColor = #colorLiteral(red: 0.3460897207, green: 0.7455198169, blue: 0.7799417377, alpha: 1)
            sigUpButton.isEnabled = true
        } else {
            sigUpButton.backgroundColor = #colorLiteral(red: 0.80188936, green: 0.9210196137, blue: 0.9322513938, alpha: 1)
            sigUpButton.isEnabled = false
        }
    }
}

final class UniversalButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupButton() {
        layer.cornerRadius = 12
        frame = CGRect(x: 0, y: 700, width: 335, height: 44)
        backgroundColor = #colorLiteral(red: 0.3460897207, green: 0.7455198169, blue: 0.7799417377, alpha: 1)
    }
}
