// ThanksViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// tixomark
/// Экран благодарности за совершение заказа
final class ThanksViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "спасибо \n за заказъ"
        static let infoText =
            """
            Разскажи о насъ другу, отправь ему
            промокодъ
            на безплатный напитокъ и получи
            скидку 10% на слѣдующій заказъ.
            """
        static let buttonTitle = "Хорошо"
    }

    // MARK: - Visual Components

    private let headerImageView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 200, height: 86)
        view.frame.origin = CGPoint(x: 87.5, y: 58)
        view.image = UIImage(.thanksHeader)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 235, height: 128)
        label.frame.origin = CGPoint(x: 70, y: 184)

        label.textColor = .black
        label.font = .amaticSCBold?.withSize(50)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = Constants.titleText
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 325, height: 89)
        label.frame.origin = CGPoint(x: 25, y: 362)

        label.textColor = #colorLiteral(red: 0.5294118524, green: 0.5294118524, blue: 0.5294118524, alpha: 1)
        label.font = .verdana?.withSize(16)
        label.textAlignment = .center
        label.numberOfLines = 4
        label.text = Constants.infoText
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(.xIcon), for: .normal)
        button.frame.size = CGSize(width: 14, height: 14)
        button.frame.origin = CGPoint(x: 20, y: 26)
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        return button
    }()

    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 345, height: 53)
        button.frame.origin = CGPoint(x: 15, y: 632)
        button.setTitle(Constants.buttonTitle, for: .normal)
        button.backgroundColor = .torquoiseAccent
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(closeButton, headerImageView, titleLabel, infoLabel, okButton)
    }

    /// Обработчик нажатия на кнопку закрытия экрана
    @objc private func didTapCloseButton() {
        dismiss(animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
}
