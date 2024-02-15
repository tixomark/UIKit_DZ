// OrderConfirmationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с проверкой кода из смс
final class OrderConfirmationViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let title = "Кодъ из СМС"
        static let titleOrderName = "Введите кодъ изъ смс, чтобы подтвердить оплату"
        static let doneButtonTitle = "Подтвердить"
        static let resendCodeButtonName = "Отправить снова"
    }

    // MARK: - visual components

    private lazy var titleOrderLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleOrderName
        label.frame = .init(x: 35, y: 146, width: 315, height: 44)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    private lazy var doneButton: SubmissionButton = {
        let button = SubmissionButton()
        button.frame = .init(x: 16, y: 700, width: 330, height: 44)
        button.setTitle(Constants.doneButtonTitle, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.80188936, green: 0.9210196137, blue: 0.9322513938, alpha: 1)
        button.center.x = view.center.x
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var codeTextField: UITextField = {
        let code = UITextField()
        code.frame = .init(x: 61, y: 217, width: 262, height: 44)
        code.layer.cornerRadius = 10
        code.keyboardType = .numberPad
        code.borderStyle = .roundedRect
        code.delegate = self
        code.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingChanged)
        return code
    }()

    private lazy var resendCodeButton: UIButton = {
        let button = UIButton()
        button.frame = .init(x: 109, y: 288, width: 167, height: 36)
        button.backgroundColor = #colorLiteral(red: 0.9781246781, green: 0.9683033824, blue: 0.9684737325, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitleColor(#colorLiteral(red: 0.3460897207, green: 0.7455198169, blue: 0.7799417377, alpha: 1), for: .normal)
        button.setTitle(Constants.resendCodeButtonName, for: .normal)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureNavBar() {
        view.backgroundColor = .white
        UIBarButtonItem.appearance().tintColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .done,
            target: self,
            action: #selector(popViewController)
        )
        title = Constants.title
    }

    private func configureUI() {
        view.addSubview(titleOrderLabel)
        view.addSubview(doneButton)
        view.addSubview(resendCodeButton)
        view.addSubview(codeTextField)
    }

    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func doneButtonTapped() {
        let thanksViewController = ThanksViewController()
        thanksViewController.completion = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        thanksViewController.modalPresentationStyle = .fullScreen
        present(thanksViewController, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension OrderConfirmationViewController: UITextFieldDelegate {
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        let textCode = codeTextField.text ?? ""
        if !textCode.isEmpty {
            doneButton.backgroundColor = .enabled
            doneButton.isEnabled = true
        } else {
            doneButton.backgroundColor = .disable
            doneButton.isEnabled = false
        }
    }
}
