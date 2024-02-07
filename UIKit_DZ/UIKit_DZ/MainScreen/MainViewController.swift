// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Main screen view
final class MainViewController: UIViewController {
    // MARK: - Public Properties

    var model = Model()
    var guessNumberGame = GuessNumberGame()

    let backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.contents = UIImage(.backgroundImage)?.cgImage
        layer.contentsGravity = .resizeAspectFill
        layer.masksToBounds = true
        return layer
    }()

    let greetingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Verdana", size: 30)
        label.textAlignment = .center
        label.textColor = .systemBackground
        label.backgroundColor = .customBlue
        label.numberOfLines = 0
        label.layer.borderColor = UIColor.systemBackground.cgColor
        label.layer.borderWidth = 3
        return label
    }()

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

    // MARK: - Private Properties

    private var greetingAlertDoneAktion: UIAlertAction?
    private var guessNumberAlertOkAktion: UIAlertAction?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showGreetingAlert()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundLayer.frame = CGRect(
            origin: CGPoint(x: 0, y: view.safeAreaInsets.top),
            size: view.bounds.size
        )
        greetingLabel.frame = CGRect(
            origin: CGPoint(x: 0, y: view.safeAreaInsets.top),
            size: CGSize(width: view.bounds.width, height: 82)
        )
    }

    // MARK: - Private Methods

    private func setUpUI() {
        view.backgroundColor = .systemBackground

        guessNumberButton.frame = CGRect(x: 82, y: 301, width: 150, height: 150)
        guessNumberButton.addTarget(
            self,
            action: #selector(didTapButton(_:)),
            for: .touchUpInside
        )

        calculatorButton.frame = CGRect(x: 132, y: 507, width: 200, height: 200)
        calculatorButton.addTarget(
            self,
            action: #selector(didTapButton(_:)),
            for: .touchUpInside
        )

        view.layer.addSublayer(backgroundLayer)
        view.addSubviews(greetingLabel, guessNumberButton, calculatorButton)
    }

    private func showGreetingAlert() {
        let greetingAlert = createGreetingAlert()
        present(greetingAlert, animated: true)
    }

    private func createGreetingAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "Пожалуйста,\nпредставьтесь",
            message: nil,
            preferredStyle: .alert
        )

        greetingAlertDoneAktion = UIAlertAction(
            title: "Готово",
            style: .default
        ) { [greetingLabel] _ in
            greetingLabel.text = "Приветствую,\n" + self.model.userName + "!"
        }

        greetingAlertDoneAktion?.isEnabled = false
        if let greetingAlertDoneAktion {
            alert.addAction(greetingAlertDoneAktion)
        }
        alert.addTextField { textfield in
            textfield.placeholder = "Введите ваше имя"
            textfield.tag = 0
            textfield.addTarget(
                self,
                action: #selector(self.textDidChangeIn(_:)),
                for: .editingChanged
            )
            textfield.returnKeyType = .done
        }

        return alert
    }

    @objc private func textDidChangeIn(_ sender: UITextField) {
        switch sender.tag {
        case 0:
            guard let text = sender.text else { return }
            greetingAlertDoneAktion?.isEnabled = !text.isEmpty
            model.userName = text
        case 1:
            model.firstNumber = Float(sender.text ?? "0") ?? 0
        case 2:
            model.secondNumber = Float(sender.text ?? "0") ?? 0
        case 3:
            if let text = sender.text, let number = Int(text), (1 ... 10) ~= number {
                guessNumberAlertOkAktion?.isEnabled = true
                guessNumberGame.suggestedNumber = number
            } else {
                guessNumberAlertOkAktion?.isEnabled = false
            }
        default:
            break
        }
    }

    @objc private func didTapButton(_ sender: UIButton) {
        switch sender {
        case guessNumberButton:
            guessNumberGame.delegate = self
            showGuessNumberAlert(title: "Угадай число от 1 до 10", message: nil)
        case calculatorButton:
            showEnterTwoNumbersAlert()
        default:
            break
        }
    }
}

extension MainViewController: GuessNumberGameDelegate {
    func suggestedNumber(_ position: GuessNumberGame.PositionRelativeToTakenNumber) {
        switch position {
        case .isTakenNumber:
            showSuccessAlert()
        case .greaterThanTakenNumer:
            showGuessNumberAlert(
                title: "Попробуйте еще раз",
                message: "Вы ввели слишком большое число"
            )
        case .lessThanTakenNumber:
            showGuessNumberAlert(
                title: "Попробуйте еще раз",
                message: "Вы ввели слишком маленькое число"
            )
        }
    }

    private func showGuessNumberAlert(title: String, message: String?) {
        let guessNumberAlert = createGuessNumberAlert(title: title, message: message)
        present(guessNumberAlert, animated: true)
    }

    private func showSuccessAlert() {
        let alert = UIAlertController(
            title: "Поздравляю!",
            message: "Вы угадали",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ок", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    private func createGuessNumberAlert(
        title: String,
        message: String?
    ) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        guessNumberAlertOkAktion = UIAlertAction(title: "Ок", style: .cancel) { _ in
            self.guessNumberGame.checkSuggestNumber()
        }
        guessNumberAlertOkAktion?.isEnabled = false

        alert.addAction(cancelAction)
        if let guessNumberAlertOkAktion {
            alert.addAction(guessNumberAlertOkAktion)
        }
        alert.addTextField { textfield in
            textfield.placeholder = "Введите число"
            textfield.tag = 3
            textfield.addTarget(
                self,
                action: #selector(self.textDidChangeIn(_:)),
                for: .editingChanged
            )
            textfield.keyboardType = .numberPad
        }
        return alert
    }
}

// Operations ower two numbers alerts
extension MainViewController {
    private func showEnterTwoNumbersAlert() {
        let enterTwoNumbersAlert = createEnterTwoNumbersAlert()
        present(enterTwoNumbersAlert, animated: true)
    }

    private func showSelectOperationAlert() {
        let selectOperationAlert = createSelectOperationAlert()
        present(selectOperationAlert, animated: true)
    }

    private func showCalculationResultAlert() {
        let calculationResultAlert = createCalculationResultAlert()
        present(calculationResultAlert, animated: true)
    }

    private func createEnterTwoNumbersAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "Введите ваши числа",
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField { textfield in
            textfield.placeholder = "Число 1"
            textfield.tag = 1
            textfield.keyboardType = .numberPad
            textfield.addTarget(
                self,
                action: #selector(self.textDidChangeIn(_:)),
                for: .editingChanged
            )
        }
        alert.addTextField { textfield in
            textfield.placeholder = "Число 2"
            textfield.tag = 2
            textfield.keyboardType = .numberPad
            textfield.addTarget(
                self,
                action: #selector(self.textDidChangeIn(_:)),
                for: .editingChanged
            )
        }

        let selectOperationAction = UIAlertAction(
            title: "Выбрать операцию",
            style: .cancel
        ) { [unowned self] _ in
            showSelectOperationAlert()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)

        alert.addAction(selectOperationAction)
        alert.addAction(cancelAction)

        return alert
    }

    private func createSelectOperationAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "Выберите математическую операцию",
            message: nil,
            preferredStyle: .alert
        )

        for operation in ArithmeticOperation.allCases {
            let action = UIAlertAction(title: operation.rawValue, style: .default) { _ in
                self.model.operation = operation
                self.showCalculationResultAlert()
            }
            alert.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(cancelAction)

        return alert
    }

    private func createCalculationResultAlert() -> UIAlertController {
        let operationResult = model.performOperation()
        let alert = UIAlertController(
            title: "Ваш результат",
            message: "\(operationResult)",
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        let okAction = UIAlertAction(title: "Ок", style: .cancel)

        alert.addAction(cancelAction)
        alert.addAction(okAction)
        return alert
    }
}
