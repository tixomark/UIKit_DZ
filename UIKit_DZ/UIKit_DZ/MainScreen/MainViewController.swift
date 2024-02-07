// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Main screen view
final class MainViewController: UIViewController {
    // MARK: - Public Properties

    var model = Model()

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

    private var greetingAlertDoneActionn: UIAlertAction?

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
        guessNumberButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)

        calculatorButton.frame = CGRect(x: 132, y: 507, width: 200, height: 200)
        calculatorButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)

        view.layer.addSublayer(backgroundLayer)
        view.addSubviews(greetingLabel, guessNumberButton, calculatorButton)
    }
    
    private func showGreetingAlert() {
        greetingAlertDoneActionn = UIAlertAction(title: "Готово", style: .default) { [greetingLabel] _ in
            greetingLabel.text = "Приветствую,\n" + self.model.userName + "!"
        }
        let greetingAlert = UIAlertController(
            title: "Пожалуйста,\nпредставьтесь",
            message: nil,
            preferredStyle: .alert
        )

        greetingAlertDoneActionn?.isEnabled = false
        if let greetingAlertDoneActionn {
            greetingAlert.addAction(greetingAlertDoneActionn)
        }
        greetingAlert.addTextField { textfield in
            textfield.placeholder = "Введите ваше имя"
            textfield.tag = 0
            textfield.addTarget(self, action: #selector(self.textDidChangeIn(_:)), for: .editingChanged)
            textfield.returnKeyType = .done
        }

        present(greetingAlert, animated: true)
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
        let operationResult = model.performOperation(.add)
        let calculationResultAlert = UIAlertController(
            title: "Ваш результат",
            message: "\(operationResult)",
            preferredStyle: .alert
        )

        calculationResultAlert.addAction(cancelAction)
        calculationResultAlert.addAction(okAction)

        present(calculationResultAlert, animated: true)
    }

    @objc private func textDidChangeIn(_ sender: UITextField) {
        switch sender.tag {
        case 0:
            guard let text = sender.text else { return }
            greetingAlertDoneActionn?.isEnabled = !text.isEmpty
            model.userName = text
        case 1:
            model.firstNumber = Int(sender.text ?? "0") ?? 0
        case 2:
            model.secondNumber = Int(sender.text ?? "0") ?? 0
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
