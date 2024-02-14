// MenuItemIngridientsConfigurationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран с добавление конфигураций напитка
final class MenuItemIngridientsConfigurationViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleLabelName = "Выберите дополнительные ингредіенты"
        static let ingridientMilkTitleName = "Молоко"
        static let ingridientSiropTitleName = "Сироп"
        static let ingridientSoyMilkTitleName = "Молоко соевое"
        static let ingridientAlmondMilkTitleName = "Молоко миндальное"
        static let ingridientEspressoTitleName = "Еспрессо 50мл"
    }

    // MARK: - visual components

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.frame = .init(x: 20, y: 26, width: 14, height: 14)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.frame = CGRect(x: 40, y: 53, width: 294, height: 44)
        text.numberOfLines = 2
        text.text = Constants.titleLabelName
        text.textAlignment = .center
        text.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        return text
    }()

    private lazy var ingridientMilkTitle = ChekBoxView()
    private lazy var ingridientSiropTitle = ChekBoxView()
    private lazy var ingridientSoyMilkTitle = ChekBoxView()
    private lazy var ingridientAlmondMilkTitle = ChekBoxView()
    private lazy var ingridientEspressoTitle = ChekBoxView()

    // MARK: - Public propities

    /// кложура для передачи данных назад
    var closure: (([(name: String, coast: Int)]) -> ())?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        makeIngridients(chekbox: ingridientMilkTitle, title: Constants.ingridientMilkTitleName, price: 50, lineY: 124)
        makeIngridients(chekbox: ingridientSiropTitle, title: Constants.ingridientSiropTitleName, price: 20, lineY: 174)
        makeIngridients(
            chekbox: ingridientSoyMilkTitle,
            title: Constants.ingridientSoyMilkTitleName,
            price: 50,
            lineY: 224
        )
        makeIngridients(
            chekbox: ingridientAlmondMilkTitle,
            title: Constants.ingridientAlmondMilkTitleName,
            price: 70,
            lineY: 274
        )
        makeIngridients(
            chekbox: ingridientEspressoTitle,
            title: Constants.ingridientEspressoTitleName,
            price: 50,
            lineY: 324
        )
    }

    private func makeIngridients(chekbox: ChekBoxView, title: String, price: Int, lineY: Int) {
        chekbox.title.text = title
        chekbox.frame = .init(x: 0, y: lineY, width: Int(view.frame.width), height: 30)
        chekbox.nubmerPrice = price
        chekbox.setupChekbox()
        view.addSubview(chekbox)
    }

    @objc private func dismissViewController() {
        let array = [
            ingridientMilkTitle,
            ingridientSiropTitle,
            ingridientSoyMilkTitle,
            ingridientAlmondMilkTitle,
            ingridientEspressoTitle
        ]
        var order = [(name: String, coast: Int)]()
        for value in array where value.isActive.isOn {
            guard let title = value.title.text else { return }
            order.append((name: title, coast: value.nubmerPrice))
        }
        closure?(order)
        dismiss(animated: true)
    }
}
