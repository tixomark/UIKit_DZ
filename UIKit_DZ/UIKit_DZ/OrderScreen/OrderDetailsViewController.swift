// OrderDetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// tixomark
/// Экран показывет сводку по созданному заказу с предложением оплатить его
final class OrderDetailsViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Вашъ Заказъ"
        static let totalSum = "Цѣна - "
        static let currency = " руб"
        static let payText = "Оплатить"

        static let insetFromTopOfScreen = 155
        static let interItemSpaceing = 6
    }

    // MARK: - Visual Components

    private let leftHeaderImageView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 100, height: 72)
        view.frame.origin = CGPoint(x: 20, y: 47)
        view.image = UIImage(.header)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let rightHeaderImageView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 100, height: 72)
        view.frame.origin = CGPoint(x: 255, y: 47)
        view.image = UIImage(.header)?.withHorizontallyFlippedOrientation()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 140, height: 30)
        label.frame.origin = CGPoint(x: 117.5, y: 100)

        label.textColor = .black
        label.font = .verdanaBold?.withSize(18)
        label.textAlignment = .center
        label.text = Constants.titleText
        return label
    }()

    private let totalSumLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 231, height: 30)
        label.frame.origin = CGPoint(x: 72, y: 443)

        label.textColor = .black
        label.font = .verdanaBold?.withSize(18)
        label.textAlignment = .center
        return label
    }()

    private let footerImageView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 100, height: 40)
        view.frame.origin = CGPoint(x: 137.5, y: 472)
        view.image = UIImage(.footer)
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(.xIcon), for: .normal)
        button.frame.size = CGSize(width: 14, height: 14)
        button.frame.origin = CGPoint(x: 20, y: 26)
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        return button
    }()

    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 345, height: 53)
        button.frame.origin = CGPoint(x: 15, y: 632)
        button.backgroundColor = .torquoiseAccent
        button.setTitle(Constants.payText, for: .normal)
        button.addTarget(self, action: #selector(didTapPayButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    /// Обработчик срабатывающий при закрытии экрана
    var completion: (() -> ())?

    /// Данные о позициях чека с экрана конфигурации позиции
    var orderPositions = [(name: String, cost: Int)]()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(closeButton, leftHeaderImageView, rightHeaderImageView)
        view.addSubviews(titleLabel, totalSumLabel, footerImageView, payButton)
        setOrderEntriesList()
    }

    /// Создает, заполняет и расставляет вью с позициями чека
    private func setOrderEntriesList() {
        var totalSum = 0

        for (index, entry) in orderPositions.enumerated() {
            let view = OrderEntryView()
            view.frame.size = CGSize(width: 335, height: 30)
            let viewOriginY = Constants
                .insetFromTopOfScreen + (Int(view.frame.height) + Constants.interItemSpaceing) * index
            view.frame.origin = CGPoint(x: 20, y: viewOriginY)
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

    @objc private func didTapCloseButton() {
        dismiss(animated: true)
    }

    @objc private func didTapPayButton() {
        dismiss(animated: true)
        completion?()
    }
}
