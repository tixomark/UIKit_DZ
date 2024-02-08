// UserModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// User model that is used to validate user related data
class UserModel {
    // MARK: - Constants

    private let loginRegEx = ##"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,10}"##
    private let passwordRegEx = ##"[a-zA-Z0-9!"#$%&'()*+,-./:;<=>?@\[\]^_`{|}~]{8,32}"##

    // MARK: - Public Properties

    var login: String? {
        didSet {
            let oldIsLogInPossible = isLogInPossible
            if let result = login?.validateUsing(loginRegEx) {
                isLoginValid = result
            }
            if isLogInPossible != oldIsLogInPossible {
                validationResultReceiver?.loginAndPaswordValidationChangedTo(isLogInPossible)
            }
        }
    }

    var password: String? {
        didSet {
            let oldIsLogInPossible = isLogInPossible
            if let result = password?.validateUsing(passwordRegEx) {
                isPasswordValid = result
            }
            if isLogInPossible != oldIsLogInPossible {
                validationResultReceiver?.loginAndPaswordValidationChangedTo(isLogInPossible)
            }
        }
    }

    weak var validationResultReceiver: UserFieldsValidationResultReceiver?

    // MARK: - Private Properties

    private var isLoginValid = false
    private var isPasswordValid = false
    private var isLogInPossible: Bool {
        isLoginValid && isPasswordValid
    }
}

protocol UserFieldsValidationResultReceiver: AnyObject {
    func loginAndPaswordValidationChangedTo(_ doesConform: Bool)
}
