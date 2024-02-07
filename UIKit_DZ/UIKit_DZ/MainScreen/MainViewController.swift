// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Main screen view
final class MainViewController: UIViewController {
    // MARK: - Public Properties

    var firstNumber = 0
    var secondNumber = 0

    let guessNumberButton: CUIButton = {
        let button = CUIButton()
        button.backgroundColor = .customPurple
        button.layer.borderColor = UIColor.customPurpleStroke.cgColor
        button.setTitle("Угадай число", for: .normal)
        return button
    }()

    let calculatorButton: CUIButton = {
        let button = CUIButton()
        button.backgroundColor = .customGreen
        button.layer.borderColor = UIColor.customGreenStroke.cgColor
        button.setTitle("Калькулятор", for: .normal)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: - Private Methods

    private func setUpUI() {
        view.backgroundColor = .systemBackground

        // set up background image
        let backgroundLayer = CALayer()
        backgroundLayer.frame = CGRect(
            origin: CGPoint(x: 0, y: view.safeAreaInsets.top),
            size: view.bounds.size
        )
        backgroundLayer.contents = UIImage(.backgroundImage)?.cgImage
        backgroundLayer.contentsGravity = .resizeAspectFill
        view.layer.addSublayer(backgroundLayer)

        guessNumberButton.frame = CGRect(x: 82, y: 301, width: 150, height: 150)
        guessNumberButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)

        calculatorButton.frame = CGRect(x: 132, y: 507, width: 200, height: 200)
        calculatorButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        view.addSubviews(guessNumberButton, calculatorButton)
    }

    private func showEnterTwoNumbersAlert() {
        let addAction = UIAlertAction(title: "Сложить", style: .cancel) { [unowned self] _ in
            showCalculationResultAlert()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        let enterTwoNumbersAlert = UIAlertController(
            title: "Введите ваши числа",
            message: nil,
            preferredStyle: .alert
        )

        enterTwoNumbersAlert.addAction(addAction)
        enterTwoNumbersAlert.addAction(cancelAction)
        enterTwoNumbersAlert.addTextField { textfield in
            textfield.placeholder = "Число 1"
            textfield.tag = 1
            textfield.keyboardType = .numberPad
            textfield.addTarget(self, action: #selector(self.textDidChangeIn(_:)), for: .editingChanged)
        }
        enterTwoNumbersAlert.addTextField { textfield in
            textfield.placeholder = "Число 2"
            textfield.tag = 2
            textfield.keyboardType = .numberPad
            textfield.addTarget(self, action: #selector(self.textDidChangeIn(_:)), for: .editingChanged)
        }

        present(enterTwoNumbersAlert, animated: true)
    }

    private func showCalculationResultAlert() {
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        let okAction = UIAlertAction(title: "Ок", style: .cancel)
        let calculationResultAlert = UIAlertController(
            title: "Ваш результат",
            message: "\(firstNumber + secondNumber)",
            preferredStyle: .alert
        )

        calculationResultAlert.addAction(cancelAction)
        calculationResultAlert.addAction(okAction)

        present(calculationResultAlert, animated: true)
    }

    @objc private func textDidChangeIn(_ sender: UITextField) {
        switch sender.tag {
        case 1:
            firstNumber = Int(sender.text ?? "0") ?? 0
        case 2:
            secondNumber = Int(sender.text ?? "0") ?? 0
        default:
            break
        }
    }

    @objc private func didTapButton(_ sender: UIButton) {
        switch sender {
        case guessNumberButton:
            print("guessNumberButton tapped")
        case calculatorButton:
            showEnterTwoNumbersAlert()
        default:
            break
        }
    }
}
