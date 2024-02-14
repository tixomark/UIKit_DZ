// OrderConfirmationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с проверкой кода из смс
final class OrderConfirmationViewController: UIViewController {
    // MARK: - visual components

    /// тайтл  верхний
    private lazy var titleOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите кодъ изъ смс, чтобы подтвердить оплату"
        label.frame = .init(x: 35, y: 146, width: 315, height: 44)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    /// кнопка для подтверждениия заказа
    private lazy var doneButton: UniversalButton = {
        let button = UniversalButton()
        button.frame = .init(x: 16, y: 700, width: 330, height: 44)
        button.setTitle("Подтвердить", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.80188936, green: 0.9210196137, blue: 0.9322513938, alpha: 1)
        button.center.x = view.center.x
        return button
    }()

    /// текст филд с полем ввода кода из смс
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

    /// кнопка для отправки кода повторно
    private lazy var resendCodeButton: UIButton = {
        let button = UIButton()
        button.frame = .init(x: 109, y: 288, width: 167, height: 36)
        button.backgroundColor = #colorLiteral(red: 0.9781246781, green: 0.9683033824, blue: 0.9684737325, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitleColor(#colorLiteral(red: 0.3460897207, green: 0.7455198169, blue: 0.7799417377, alpha: 1), for: .normal)
        button.setTitle("Отправить снова", for: .normal)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createNavBar()
        setupUI()
    }

    // MARK: - Private Methods

    /// настройки навиигейшн бара
    private func createNavBar() {
        view.backgroundColor = .white
        UIBarButtonItem.appearance().tintColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .done,
            target: self,
            action: #selector(popVC)
        )
        title = "Кодъ из СМС"
    }

    /// кладем элементы на вью
    private func setupUI() {
        view.addSubview(titleOrderLabel)
        view.addSubview(doneButton)
        view.addSubview(resendCodeButton)
        view.addSubview(codeTextField)
    }

    /// метод для возврата назад
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension OrderConfirmationViewController: UITextFieldDelegate {
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        let textCode = codeTextField.text ?? ""
        if !textCode.isEmpty {
            doneButton.backgroundColor = #colorLiteral(red: 0.3460897207, green: 0.7455198169, blue: 0.7799417377, alpha: 1)
            doneButton.isEnabled = true
        } else {
            doneButton.backgroundColor = #colorLiteral(red: 0.80188936, green: 0.9210196137, blue: 0.9322513938, alpha: 1)
            doneButton.isEnabled = false
        }
    }
}
