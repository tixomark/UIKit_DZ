// UserDataViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с информацией о пользователе
final class UserDataViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let backBarButtonImage = UIImage(systemName: "chevron.backward")
        static let title = "Мои данные"
        static let nameText = "Имя"
        static let secondNameText = "Фамилия"
        static let numberPhoneText = "Номер телефона"
        static let sizeShoesText = "Размер ноги"
        static let birdthdayText = "Дата Рождения"
        static let emailText = "Почта"
        static let buttonTitle = "Сохранить"
    }

    // MARK: - Visual Components

    private var nameTextField = UITextField()
    private var secondNameField = UITextField()
    private var numberPhoneTextField = UITextField()
    private var sizeShoesTextField = UITextField()
    private var birdthdayTextField = UITextField()
    private var emailTextField = UITextField()
    private var datePicker = UIDatePicker(frame: .zero)

    private lazy var saveConfigUserButton: SubmissionButton = {
        let button = SubmissionButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.buttonTitle, for: .normal)
        return button
    }()

    // MARK: - Private Properties

    private let maximumNumberItem = 11
    private let regex = try? NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Private Methods

    private func formatinPhoneNumber(phoneNuumber: String, shouldRemoveLastDigit: Bool) -> String {
        guard let regex = regex else { return "" }
        guard !(shouldRemoveLastDigit && phoneNuumber.count <= 2) else { return "+" }

        let range = NSString(string: phoneNuumber).range(of: phoneNuumber)
        var number = regex.stringByReplacingMatches(in: phoneNuumber, options: [], range: range, withTemplate: "")

        if number.count > maximumNumberItem {
            let maxIndex = number.index(number.startIndex, offsetBy: maximumNumberItem)
            number = String(number[number.startIndex ..< maxIndex])
        }

        if shouldRemoveLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex ..< maxIndex])
        }
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex ..< maxIndex
        if number.count < 7 {
            let patern = "(\\d)(\\d{3})(\\d+)"
            number = number.replacingOccurrences(
                of: patern,
                with: "$1 ($2) $3",
                options: .regularExpression,
                range: regRange
            )
        } else {
            let patern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
            number = number.replacingOccurrences(
                of: patern,
                with: "$1 ($2) $3-$4-$5",
                options: .regularExpression,
                range: regRange
            )
        }
        return "+" + number
    }

    private func configure() {
        view.backgroundColor = .systemBackground
        configureNavBar()
        makeTextFields(textField: nameTextField, placeholder: Constants.nameText, tag: 1)
        makeTextFields(textField: secondNameField, placeholder: Constants.secondNameText, tag: 2)
        makeTextFields(textField: numberPhoneTextField, placeholder: Constants.numberPhoneText, tag: 3)
        makeTextFields(textField: sizeShoesTextField, placeholder: Constants.sizeShoesText, tag: 4)
        makeTextFields(textField: birdthdayTextField, placeholder: Constants.birdthdayText, tag: 5)
        makeTextFields(textField: emailTextField, placeholder: Constants.emailText, tag: 6)
        makeDatePiker()
        view.addSubview(saveConfigUserButton)
        makeAnchor()
    }

    private func configureNavBar() {
        tabBarController?.tabBar.isHidden = true
        title = Constants.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Constants.backBarButtonImage,
            style: .done,
            target: self,
            action: #selector(popViewController)
        )
    }

    private func makeTextFields(textField: UITextField, placeholder: String, tag: Int) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 12
        textField.placeholder = placeholder
        textField.backgroundColor = .backgroundAccent
        textField.delegate = self
        let findTextFieldView = UIView(frame: CGRect(x: 8.0, y: 12.0, width: 20.0, height: 20.0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = findTextFieldView
        textField.tag = tag
        if tag == 4 {
            textField.addTarget(
                self,
                action: #selector(presentSizeViewController),
                for: .editingDidBegin
            )
        }
        view.addSubview(textField)
    }

    private func makeDatePiker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(datePickerChange), for: .valueChanged)
        datePicker.dropShadow(width: -10, height: -10)
        birdthdayTextField.inputView = datePicker
    }

    private func makeAnchor() {
        makeNameTextFieldAnchor()
        makeAnchorSecondTextField()
        makeNumberTextFieldAnchor()
        makeSizeShoesTextFieldAnchor()
        makeBirdthdayTextFieldAnchor()
        emailTextFieldAnchor()
        saveConfigUserButtonAnchor()
    }

    @objc private func popViewController() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }

    @objc func datePickerChange(paramDatePickker: UIDatePicker) {
        if paramDatePickker.isEqual(datePicker) {
            birdthdayTextField.text = paramDatePickker.date.formatted(date: .numeric, time: .omitted)
        }
        view.endEditing(true)
        emailTextField.becomeFirstResponder()
    }

    @objc private func presentSizeViewController() {
        let sizeViewController = FootSizeViewController()
        sizeViewController.modalPresentationStyle = .overFullScreen
        sizeViewController.modalTransitionStyle = .crossDissolve
        sizeViewController.dataTransmissionHandler = { size in
            self.sizeShoesTextField.text = size
        }
        present(sizeViewController, animated: true)
    }
}

// MARK: - Make Anchor

extension UserDataViewController {
    private func makeNameTextFieldAnchor() {
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 113).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private func makeAnchorSecondTextField() {
        secondNameField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        secondNameField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        secondNameField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        secondNameField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private func makeNumberTextFieldAnchor() {
        numberPhoneTextField.topAnchor.constraint(equalTo: secondNameField.bottomAnchor, constant: 10).isActive = true
        numberPhoneTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        numberPhoneTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        numberPhoneTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private func makeSizeShoesTextFieldAnchor() {
        sizeShoesTextField.topAnchor.constraint(equalTo: numberPhoneTextField.bottomAnchor, constant: 10)
            .isActive = true
        sizeShoesTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        sizeShoesTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        sizeShoesTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private func makeBirdthdayTextFieldAnchor() {
        birdthdayTextField.topAnchor.constraint(equalTo: sizeShoesTextField.bottomAnchor, constant: 10).isActive = true
        birdthdayTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        birdthdayTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        birdthdayTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private func emailTextFieldAnchor() {
        emailTextField.topAnchor.constraint(equalTo: birdthdayTextField.bottomAnchor, constant: 10).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private func saveConfigUserButtonAnchor() {
        saveConfigUserButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -114).isActive = true
        saveConfigUserButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        saveConfigUserButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
}

// MARK: - UITextFieldDelegate

extension UserDataViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        guard let nextResponder = view.viewWithTag(nextTag) else {
            textField.resignFirstResponder()
            return true
        }

        switch textField.tag {
        case 3:
            textField.resignFirstResponder()
            presentSizeViewController()
        case 1, 2, 4, 5:
            nextResponder.becomeFirstResponder()
        default:
            break
        }
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 4 {
            textField.resignFirstResponder()
        }
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if textField == numberPhoneTextField {
            let fullString = (textField.text ?? "") + string
            textField.text = formatinPhoneNumber(phoneNuumber: fullString, shouldRemoveLastDigit: range.length == 1)
            return false
        }
        return true
    }
}
