// UserModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// User model that is used to validate user related data
class UserModel {
    var login: String? {
        didSet {
            isLoginValid = (login ?? "").count > 5
            validationResultReceiver?.loginAndPaswordValidationChangedTo(isLogInPossible)
        }
    }

    var password: String? {
        didSet {
            isPasswordValid = (password ?? "").count > 5
            validationResultReceiver?.loginAndPaswordValidationChangedTo(isLogInPossible)
        }
    }

    weak var validationResultReceiver: UserFieldsValidationResultReceiver?

    private var isLoginValid = false
    private var isPasswordValid = false

    private var isLogInPossible: Bool {
        isLoginValid && isPasswordValid
    }
}

protocol UserFieldsValidationResultReceiver: AnyObject {
    func loginAndPaswordValidationChangedTo(_ doesConform: Bool)
}
