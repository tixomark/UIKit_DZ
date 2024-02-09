// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный экран приложения с кнопками начала игры "угадай число" и калькулятора
final class MainViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let guessNumberButtonTitle = "Угадай число"
        static let calculatorButtonTitle = "Калькулятор"

        enum GreetingAlert {
            static let title = "Пожалуйста,\nпредставьтесь"
            static let enterYourName = "Введите ваше имя"
        }

        enum GuessNumberAlert {
            static let baseTitle = "Угадай число от 1 до 10"
            static let tryAgainTitle = "Попробуйте еще раз"

            static let veryBigNumberMessage = "Вы ввели слишком большое число"
            static let verySmallNumberMessage = "Вы ввели слишком маленькое число"
        }

        enum SuccessAlert {
            static let title = "Поздравляю!"
            static let message = "Вы угадали"
        }

        enum EnterTwoNumbersAlert {
            static let title = "Введите ваши числа"
            static let selectOperationTitle = "Выбрать операцию"
        }

        enum SelectOperationAlert {
            static let title = "Выберите математическую операцию"
        }

        enum CalculationResultAlert {
            static let title = "Ваш результат"
        }
    }

    // MARK: - Private Properties

    /// Задний фон всего экрана
    private let backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.contents = UIImage(.backgroundImage)?.cgImage
        layer.contentsGravity = .resizeAspectFill
        layer.masksToBounds = true
        return layer
    }()

    /// Лейбл в верхней части экрана. Отображает приветствия с введенным  именем пользователя
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Verdana-Bold", size: 30)
        label.textAlignment = .center
        label.textColor = .systemBackground
        label.backgroundColor = .customBlue
        label.numberOfLines = 0
        label.layer.borderColor = UIColor.systemBackground.cgColor
        label.layer.borderWidth = 3
        return label
    }()

    /// Кнопка начала игра "угадай число"
    private let guessNumberButton: CUIButton = {
        let button = CUIButton()
        button.backgroundColor = .customPurple
        button.layer.borderColor = UIColor.customPurpleStroke.cgColor
        button.setTitle(Constants.guessNumberButtonTitle, for: .normal)
        return button
    }()

    /// Кнопка вызывающая окно калькулятора
    private let calculatorButton: CUIButton = {
        let button = CUIButton()
        button.backgroundColor = .customGreen
        button.layer.borderColor = UIColor.customGreenStroke.cgColor
        button.setTitle(Constants.calculatorButtonTitle, for: .normal)
        return button
    }()

    /// UIAlertAction ы к которве нужно активировать/деактивировать в зависимости от ввода пользователя
    private var greetingAlertDoneAktion: UIAlertAction?
    private var guessNumberAlertOkAktion: UIAlertAction?

    /// Модель отвечающая на функционал калькулятора
    private var numberOperator = NumberOperator()
    /// Модель отвечающая за игру в угадывание числа
    private var guessNumberGame = GuessNumberGame()

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
        setUpSubviewsFrames()
    }

    // MARK: - Private Methods

    /// Настраивает представление
    private func setUpUI() {
        view.backgroundColor = .systemBackground

        guessNumberButton.frame = CGRect(x: 82, y: 301, width: 150, height: 150)
        guessNumberButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)

        calculatorButton.frame = CGRect(x: 132, y: 507, width: 200, height: 200)
        calculatorButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)

        view.layer.addSublayer(backgroundLayer)
        view.addSubviews(greetingLabel, guessNumberButton, calculatorButton)
    }

    private func setUpSubviewsFrames() {
        backgroundLayer.frame = CGRect(
            origin: CGPoint(x: 0, y: view.safeAreaInsets.top),
            size: view.bounds.size
        )
        greetingLabel.frame = CGRect(
            origin: CGPoint(x: 0, y: view.safeAreaInsets.top),
            size: CGSize(width: view.bounds.width, height: 82)
        )
    }

    private func showGreetingAlert() {
        let greetingAlert = createGreetingAlert()
        present(greetingAlert, animated: true)
    }

    private func createGreetingAlert() -> UIAlertController {
        let alert = UIAlertController(title: Constants.GreetingAlert.title)
        greetingAlertDoneAktion = UIAlertAction(title: "Готово") { [greetingLabel] _ in
            greetingLabel.text = "Приветствую,\n" + self.numberOperator.userName + "!"
        }

        greetingAlertDoneAktion?.isEnabled = false
        if let greetingAlertDoneAktion {
            alert.addAction(greetingAlertDoneAktion)
        }
        alert.addTextField { textfield in
            textfield.placeholder = Constants.GreetingAlert.enterYourName
            textfield.tag = 0
            textfield.addTarget(self, action: #selector(self.textDidChangeIn(_:)), for: .editingChanged)
            textfield.returnKeyType = .done
        }
        return alert
    }

    @objc private func textDidChangeIn(_ sender: UITextField) {
        switch sender.tag {
        case 0:
            guard let text = sender.text else { return }
            greetingAlertDoneAktion?.isEnabled = !text.isEmpty
            numberOperator.userName = text
        case 1:
            numberOperator.firstNumber = Float(sender.text ?? "0") ?? 0
        case 2:
            numberOperator.secondNumber = Float(sender.text ?? "0") ?? 0
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
            guessNumberGame.resultReceiver = self
            showGuessNumberAlert(title: Constants.GuessNumberAlert.baseTitle, message: nil)
        case calculatorButton:
            numberOperator.resultReceiver = self
            showEnterTwoNumbersAlert()
        default:
            break
        }
    }
}

/// Отвечает за обработку попыток угадывания числа
extension MainViewController: GuessNumberGameResultReceiver {
    func suggestedNumber(_ position: GuessNumberGame.PositionRelativeToTakenNumber) {
        switch position {
        case .isTakenNumber:
            showSuccessAlert()
            guessNumberGame.resultReceiver = nil
        case .greaterThanTakenNumer:
            showGuessNumberAlert(
                title: Constants.GuessNumberAlert.tryAgainTitle,
                message: Constants.GuessNumberAlert.veryBigNumberMessage
            )
        case .lessThanTakenNumber:
            showGuessNumberAlert(
                title: Constants.GuessNumberAlert.tryAgainTitle,
                message: Constants.GuessNumberAlert.verySmallNumberMessage
            )
        }
    }
}

/// Отвещает за обработку результатов выполнения мат операций
extension MainViewController: NumberOperatorResultReceiver {
    func operationResultedWith(_ number: Float?) {
        showCalculationResultAlert(number ?? 0)
        numberOperator.resultReceiver = nil
    }
}

/// Функции создания и презентации алертов
private extension MainViewController {
    func showGuessNumberAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message)
        guessNumberAlertOkAktion = UIAlertAction.ok { _ in
            self.guessNumberGame.checkSuggestNumber()
        }
        guessNumberAlertOkAktion?.isEnabled = false
        alert.addAction(UIAlertAction.cancel)
        if let guessNumberAlertOkAktion {
            alert.addAction(guessNumberAlertOkAktion)
        }
        alert.addTextField { textfield in
            textfield.placeholder = "Введите число"
            textfield.tag = 3
            textfield.keyboardType = .numberPad
            textfield.addTarget(self, action: #selector(self.textDidChangeIn(_:)), for: .editingChanged)
        }
        alert.preferredAction = guessNumberAlertOkAktion
        present(alert, animated: true)
    }

    func showSuccessAlert() {
        let alert = UIAlertController(title: Constants.SuccessAlert.title, message: Constants.SuccessAlert.message)
        alert.addAction(UIAlertAction.ok)
        alert.preferredAction = alert.actions.last
        present(alert, animated: true)
    }

    func showEnterTwoNumbersAlert() {
        let alert = UIAlertController(title: Constants.EnterTwoNumbersAlert.title)
        for index in 1 ... 2 {
            alert.addTextField { textfield in
                textfield.placeholder = "Число \(index)"
                textfield.tag = index
                textfield.keyboardType = .numberPad
                textfield.addTarget(
                    self,
                    action: #selector(self.textDidChangeIn(_:)),
                    for: .editingChanged
                )
            }
        }
        let selectOperationAction = UIAlertAction(
            title: Constants.EnterTwoNumbersAlert
                .selectOperationTitle
        ) { [unowned self] _ in
            showSelectOperationAlert()
        }
        alert.addAction(selectOperationAction)
        alert.addAction(UIAlertAction.cancel)
        alert.preferredAction = selectOperationAction
        present(alert, animated: true)
    }

    func showSelectOperationAlert() {
        let alert = UIAlertController(title: Constants.SelectOperationAlert.title)
        for operation in ArithmeticOperation.allCases {
            let action = UIAlertAction(title: operation.rawValue) { [unowned self] _ in
                numberOperator.operation = operation
                numberOperator.performOperation()
            }
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction.cancel)
        alert.preferredAction = alert.actions.last
        present(alert, animated: true)
    }

    func showCalculationResultAlert(_ result: Float) {
        let alert = UIAlertController(
            title: Constants.CalculationResultAlert.title,
            message: "\(result)"
        )
        alert.addAction(UIAlertAction.cancel)
        alert.addAction(UIAlertAction.ok)
        alert.preferredAction = alert.actions.last
        present(alert, animated: true)
    }
}
