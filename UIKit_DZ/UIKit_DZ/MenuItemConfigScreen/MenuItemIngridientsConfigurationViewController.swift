// MenuItemIngridientsConfigurationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран с добавление конфигураций напитка
final class MenuItemIngridientsConfigurationViewController: UIViewController {
    // MARK: - visual components
    
    /// кнопка закрыть экран
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.frame = .init(x: 20, y: 26, width: 14, height: 14)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return button
    }()
    
    /// задаем тайтл
    private lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.frame = CGRect(x: 40, y: 53, width: 294, height: 44)
        text.numberOfLines = 2
        text.text = "Выберите дополнительные ингредіенты"
        text.textAlignment = .center
        text.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        return text
    }()
    
    /// индгридиент с моллоком
    private lazy var ingridientMilkTitle = ChekBoxSwitch()
    /// ингридиеннт с сироп
    private lazy var ingridientSiropTitle = ChekBoxSwitch()
    /// ингридиент с соевым молоком
    private lazy var ingridientSoyMilkTitle = ChekBoxSwitch()
    /// ингридиент с молоком индивидуалльным
    private lazy var ingridientAlmondMilkTitle = ChekBoxSwitch()
    /// ингридиент с еспрессо
    private lazy var ingridientEspressoTitle = ChekBoxSwitch()
    
    // MARK: - Public propities
    
    /// кложура для передачи данных назад
    var closure: (([(name: String, coast: Int)]) -> ())?
    
    // MARK: - Life cicly
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    /// кладем элементы на вью
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        createIngridients(chekbox: ingridientMilkTitle, title: "Молоко", price: 50, lineY: 124)
        createIngridients(chekbox: ingridientSiropTitle, title: "Сироп", price: 20, lineY: 174)
        createIngridients(chekbox: ingridientSoyMilkTitle, title: "Молоко соевое", price: 50, lineY: 224)
        createIngridients(chekbox: ingridientAlmondMilkTitle, title: "Молоко миндальное", price: 70, lineY: 274)
        createIngridients(chekbox: ingridientEspressoTitle, title: "Еспрессо 50мл", price: 50, lineY: 324)
    }
    
    /// создаем ингридиенты
    private func createIngridients(chekbox: ChekBoxSwitch, title: String, price: Int, lineY: Int) {
        chekbox.title.text = title
        chekbox.frame = .init(x: 0, y: lineY, width: Int(view.frame.width), height: 30)
        chekbox.nubmerPrice = price
        chekbox.setupChekbox()
        view.addSubview(chekbox)
    }
    
    ///  метод для закрытие экрана
    @objc private func dismissVC() {
        let array = [
            ingridientMilkTitle,
            ingridientSiropTitle,
            ingridientSoyMilkTitle,
            ingridientAlmondMilkTitle,
            ingridientEspressoTitle
        ]
        var tupleOrder = [(name: String, coast: Int)]()
        for value in array where value.isActive.isOn {
            guard let title = value.title.text else { return }
            tupleOrder.append((name: title, coast: value.nubmerPrice))
        }
        closure?(tupleOrder)
        dismiss(animated: true)
    }
}

///  Вьюшка с ценами и свитчом
final class ChekBoxSwitch: UIView {
    lazy var nubmerPrice = 0
    lazy var title = UILabel()
    lazy var price = UILabel()
    lazy var isActive = UISwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupChekbox() {
        title.frame = .init(x: 20, y: 0, width: 200, height: 35)
        title.sizeToFit()
        price.frame = .init(x: title.frame.maxX, y: 0, width: 75, height: 35)
        price.text = "  + \(nubmerPrice) руб"
        price.textColor = .systemGreen
        price.sizeToFit()
        isActive.frame = .init(x: 301, y: 0, width: 0, height: 0)
        addSubview(title)
        addSubview(price)
        addSubview(isActive)
    }
}
