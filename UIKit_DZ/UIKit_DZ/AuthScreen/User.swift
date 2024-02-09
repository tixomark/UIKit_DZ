// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс для обработчика результатов валидации пароля и логина
protocol UserFieldsValidationResultReceiver: AnyObject {
    /// Передает обновленный статут возможности авторизации
    func loginAndPaswordValidationChangedTo(_ doesConform: Bool)
}

/// Модель пользователя содержащяя пользовательские данные
final class User {
    // MARK: - Constants

    private enum Constants {
        static let loginRegEx = ##"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,10}"##
        static let passwordRegEx = ##"[a-zA-Z0-9!"#$%&'()*+,-./:;<=>?@\[\]^_`{|}~]{8,32}"##
    }

    // MARK: - Public Properties

    /// Содержит логин пользователя. При обновлении значения проверяет логин на корректность
    var login: String? {
        didSet {
            let oldIsLogInPossible = isLogInPossible
            if let result = login?.validateUsing(Constants.loginRegEx) {
                isLoginValid = result
            }
            if isLogInPossible != oldIsLogInPossible {
                validationResultReceiver?.loginAndPaswordValidationChangedTo(isLogInPossible)
            }
        }
    }

    /// Хранит пароль пользователя. При обновлении занчения проверяет пароль на корректность
    var password: String? {
        didSet {
            let oldIsLogInPossible = isLogInPossible
            if let result = password?.validateUsing(Constants.passwordRegEx) {
                isPasswordValid = result
            }
            if isLogInPossible != oldIsLogInPossible {
                validationResultReceiver?.loginAndPaswordValidationChangedTo(isLogInPossible)
            }
        }
    }

    /// Объект получающий обновления по результатам валидации пароля и логина
    weak var validationResultReceiver: UserFieldsValidationResultReceiver?

    // MARK: - Private Properties

    private var isLoginValid = false
    private var isPasswordValid = false
    private var isLogInPossible: Bool {
        isLoginValid && isPasswordValid
    }
}
