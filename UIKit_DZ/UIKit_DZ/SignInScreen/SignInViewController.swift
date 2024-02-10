// SignInViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран авторизации в приложении
final class SignInViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let mainTitle = "Birthday\nReminder"
        static let signInText = "Sign in"

        enum LoginView {
            static let title = "Email"
            static let placeholder = "Typing email"
        }

        enum PasswordView {
            static let title = "Password"
            static let placeholder = "Typing password"
        }

        static let authButtonTitle = "Login"
    }

    // MARK: - Private Properties

    /// Основное изображение в самом верху контроллера
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(.signInMainImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    /// Подпись основного изображения
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold?.withSize(18)
        label.text = Constants.mainTitle
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .accentPurple
        return label
    }()

    private let signInLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold?.withSize(26)
        label.textColor = .accentPink
        label.text = Constants.signInText
        label.textAlignment = .left
        return label
    }()

    /// Представление поля ввода логина
    private let emailFieldView: FormFieldView = {
        let view = FormFieldView()
        view.annotationLabel.textColor = .accentPink
        view.annotationLabel.text = Constants.LoginView.title
        view.textField.placeholder = Constants.LoginView.placeholder
        view.textField.returnKeyType = .next
        return view
    }()

    /// Представление поля ввода пароля
    private let passwordFieldView: FormFieldView = {
        let view = FormFieldView(accessoryType: .button)
        view.annotationLabel.textColor = .accentPink
        view.annotationLabel.text = Constants.PasswordView.title
        view.textField.placeholder = Constants.PasswordView.placeholder
        view.textField.returnKeyType = .done
        view.textField.isSecureTextEntry = true
        view.accessoryButton.setImage(UIImage(.closedEyeIcon), for: .normal)
        return view
    }()

    /// Кнопка аутентификации
    private let authButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .accentPink
        button.setTitle(Constants.authButtonTitle, for: .normal)
        button.titleLabel?.font = .verdanaBold?.withSize(16)
        return button
    }()

    /// Модель которая валидирует введенные данные пользователя
    private var dataValidator = UserDataValidator()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        dataValidator.validationResultReceiver = self
        setUpUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        positionSubviews()
    }

    // MARK: - Public Methods

    // swiftlint: disable custom_set_name
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // swiftlint: enable custom_set_name
        super.touchesBegan(touches, with: event)
        _ = emailFieldView.resignFirstResponder()
        _ = passwordFieldView.resignFirstResponder()
    }

    // MARK: - Private Methods

    private func setUpUI() {
        view.backgroundColor = .systemBackground

        emailFieldView.textField.delegate = self
        emailFieldView.textField.addTarget(self, action: #selector(editingChangedIn(_:)), for: .editingChanged)

        passwordFieldView.textField.delegate = self
        passwordFieldView.textField.addTarget(self, action: #selector(editingChangedIn(_:)), for: .editingChanged)
        passwordFieldView.accessoryButton.addTarget(
            self,
            action: #selector(didTapHidePasswordButton(_:)),
            for: .touchUpInside
        )
        switchPasswordVisibilityTo(false)
        setAuthButtonAvalibilityTo(false)

        view.addSubviews(headerImageView, titleLabel, signInLabel)
        view.addSubviews(emailFieldView, passwordFieldView, authButton)
    }

    /// Скрывает/показывает стоку пароля
    private func switchPasswordVisibilityTo(_ isVisible: Bool) {
        passwordFieldView.textField.isSecureTextEntry = !isVisible
        let image = UIImage(isVisible ? .openedEyeIcon : .closedEyeIcon)
        passwordFieldView.accessoryButton.setImage(image, for: .normal)
    }

    /// Изменяет даступность и отображениие  кнопки входа
    private func setAuthButtonAvalibilityTo(_ isEnabled: Bool) {
        authButton.isEnabled = isEnabled
        authButton.alpha = isEnabled ? 1 : 0.4
    }

    /// Обрабатывает нажания на кнопку скрытия пароля в passwordFieldView
    @objc private func didTapHidePasswordButton(_ sender: UIButton) {
        switchPasswordVisibilityTo(passwordFieldView.textField.isSecureTextEntry)
    }

    /// Обрабатывает введенные пользователем парол и логин. Путем передаыи их в модель валидатора данных
    @objc private func editingChangedIn(_ sender: UITextField) {
        switch sender {
        case emailFieldView.textField:
            dataValidator.login = sender.text
        case passwordFieldView.textField:
            dataValidator.password = sender.text
        default:
            break
        }
    }

    /// Для всех сабвью рассчитывает фреймы и размещает их соответственно
    /// В теле функции в именах иcпользуется сокращение V - View
    private func positionSubviews() {
        /// Рассчитывает Х коодинату исходя из ширины дочернего вью, для центрирования относительно self.view
        func centerInViewFor(_ width: CGFloat) -> CGFloat {
            (view.bounds.width - width) / 2
        }
        let viewWidth = view.bounds.width

        let imageVSide: CGFloat = 125
        let imageVSize = CGSize(width: imageVSide, height: imageVSide)
        let imageVOrigin = CGPoint(x: centerInViewFor(imageVSide), y: 70)
        headerImageView.frame = CGRect(origin: imageVOrigin, size: imageVSize)

        let titleVSize = CGSize(width: viewWidth - 200, height: 44)
        let titleVOrigin = CGPoint(x: (viewWidth - titleVSize.width) / 2, y: headerImageView.frame.maxY + 5)
        titleLabel.frame = CGRect(origin: titleVOrigin, size: titleVSize)

        // ширина вью с отступами спарва и слева
        let screenWideVWidth = viewWidth - 40
        // х координата отчентрированных вью с отступами спарва и слева
        let screenWideVOriginX = centerInViewFor(screenWideVWidth)

        let signInVSize = CGSize(width: screenWideVWidth, height: 31)
        let signInVOrigin = CGPoint(x: screenWideVOriginX, y: titleLabel.frame.maxY + 22)
        signInLabel.frame = CGRect(origin: signInVOrigin, size: signInVSize)

        var emailVSize = emailFieldView.frame.size
        emailVSize.width = screenWideVWidth
        let emailVOrigin = CGPoint(x: screenWideVOriginX, y: signInLabel.frame.maxY + 21)
        emailFieldView.frame = CGRect(origin: emailVOrigin, size: emailVSize)

        var passwordVSize = passwordFieldView.frame.size
        passwordVSize.width = screenWideVWidth
        let passwordVOrigin = CGPoint(x: screenWideVOriginX, y: emailFieldView.frame.maxY + 20)
        passwordFieldView.frame = CGRect(origin: passwordVOrigin, size: passwordVSize)

        let authBSize = CGSize(width: screenWideVWidth, height: 44)
        let authBOriginY = view.bounds.maxY - 97 - authBSize.height
        let authBOrigin = CGPoint(x: screenWideVOriginX, y: authBOriginY)
        authButton.frame = CGRect(origin: authBOrigin, size: authBSize)
    }
}

extension SignInViewController: UITextFieldDelegate {
    /// Управляет фокусировкой текстовых полей (какое поле сделать активным после нажатия Return)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailFieldView.textField:
            _ = passwordFieldView.becomeFirstResponder()
        case passwordFieldView.textField:
            _ = passwordFieldView.resignFirstResponder()
        default:
            break
        }
        return true
    }
}

extension SignInViewController: UserDataValidationResultReceiver {
    /// Обрабатывает результаты валидации пользовательских данных из модели
    func loginAndPaswordValidationChangedTo(_ doConform: Bool) {
        setAuthButtonAvalibilityTo(doConform)
    }
}
