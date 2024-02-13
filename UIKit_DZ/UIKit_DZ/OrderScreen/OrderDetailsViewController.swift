// OrderDetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// tixomark
/// Класс предоставляет
final class OrderDetailsViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let title = "Вашъ Заказъ"
        static let totalSum = "Цѣна - "
        static let currency = " руб"
        static let payText = "Оплатить"
    }

    // MARK: - Visual Components

    /// Кнопка закрытия экрана
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(.xIcon), for: .normal)
        button.frame.size = CGSize(width: 14, height: 14)
        button.frame.origin = CGPoint(x: 20, y: 26)
        return button
    }()

    /// Хедер заголовка слева (завитушки)
    private let leftHeaderView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 100, height: 72)
        view.frame.origin = CGPoint(x: 20, y: 47)
        view.image = UIImage(.header)
        view.contentMode = .scaleAspectFit
        return view
    }()

    /// Футер заголовка справа (завитушки)
    private let rightHeaderView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 100, height: 72)
        view.frame.origin = CGPoint(x: 255, y: 47)
        view.image = UIImage(.header)?.withHorizontallyFlippedOrientation()
        view.contentMode = .scaleAspectFit
        return view
    }()

    /// Отображает заголовок экрана
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 140, height: 30)
        label.frame.origin = CGPoint(x: 117.5, y: 100)

        label.textColor = .black
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        label.textAlignment = .center
        label.text = Constants.title
        return label
    }()

    /// Отображает суммарную чену чека
    private let totalSumLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 231, height: 30)
        label.frame.origin = CGPoint(x: 72, y: 443)

        label.textColor = .black
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        label.textAlignment = .center
        return label
    }()

    /// Футер заголовка меню (завитушки)
    private let footerView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 100, height: 40)
        view.frame.origin = CGPoint(x: 137.5, y: 472)
        view.image = UIImage(.footer)
        view.contentMode = .scaleAspectFit
        return view
    }()

    /// Кнопка инициации оплаты
    private let payButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 345, height: 53)
        button.frame.origin = CGPoint(x: 15, y: 632)
        button.backgroundColor = .torquoiseAccent
        button.setTitle(Constants.payText, for: .normal)
        return button
    }()

    // MARK: - Public Properties

    /// Обработчик срабатывающий при закрытии жкрана
    var completion: (() -> ())?

    /// Временная замена данных, которце должны прижодить с предудущего экрана
    var model = [
        (name: "Американо", cost: 100),
        (name: "Молоко", cost: 50),
        (name: "Эспрессо 50мл", cost: 50)
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: - Private Methods

    private func setUpUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(closeButton, leftHeaderView, rightHeaderView)
        view.addSubviews(titleLabel, totalSumLabel, footerView, payButton)
        setOrderEntriesList()

        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        payButton.addTarget(self, action: #selector(didTapPayButton), for: .touchUpInside)
    }

    /// Создает, заполняет и расставляет вью с позициями чека
    private func setOrderEntriesList() {
        var totalSum = 0

        for (index, entry) in model.enumerated() {
            let view = OrderEntryView()
            view.frame.size = CGSize(width: 335, height: 30)
            view.frame.origin = CGPoint(x: 20, y: 155 + (30 + 6) * index)
            self.view.addSubview(view)
            if index == 0 {
                view.switchToBoldFont()
            }

            let costString = "\(entry.cost)" + Constants.currency
            view.configureUsing(entry.name, cost: costString)
            totalSum += entry.cost
        }

        totalSumLabel.text = Constants.totalSum + "\(totalSum)" + Constants.currency
    }

    /// Обработчик назатия кнопки закрытия
    @objc private func didTapCloseButton() {
        dismiss(animated: true)
    }

    /// Обработчик нажатия кнопки оплаты
    @objc private func didTapPayButton() {
        dismiss(animated: true)
        completion?()
    }
}
