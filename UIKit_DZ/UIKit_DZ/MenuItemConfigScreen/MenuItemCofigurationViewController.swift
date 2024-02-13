// MenuItemCofigurationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с конфигарцией напитка
final class MenuItemCofigurationViewController: UIViewController {
    // MARK: - visual components
    
    /// кастомная верхня белая вьюшка
    private lazy var topCustomView: UIView = {
        let customView = UIView()
        customView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 346)
        customView.backgroundColor = #colorLiteral(red: 0.9428322315, green: 0.8812621236, blue: 0.8162202239, alpha: 1)
        customView.layer.cornerRadius = 20
        customView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return customView
    }()
    
    /// круглая вьюшка для кнопки назад
    private lazy var backButtonBackgroundView: UIView = {
        let customView = UIView()
        customView.frame = .init(x: 7, y: 50, width: 44, height: 44)
        customView.backgroundColor = #colorLiteral(red: 0.9217587709, green: 0.9660443664, blue: 0.969683826, alpha: 1)
        customView.layer.cornerRadius = 20
        return customView
    }()
    
    /// изображение с выбором кофе
    private lazy var itemImage: UIImageView = {
        let product = UIImageView()
        product.frame = .init(x: 0, y: 0, width: 150, height: 150)
        product.center.x = topCustomView.center.x
        product.center.y = topCustomView.center.y
        product.image = UIImage(named: "americano")
        return product
    }()
    
    /// массив сс картинкамми для сегмента
    private lazy var imageArray = [
        UIImage(named: "americano"),
        UIImage(named: "capuchino"),
        UIImage(named: "latte")
    ]
    /// массиив с эллементами выбора кофе
    let menyItem = ["Американо", "Капучино", "Латте"]
    /// массив сс тюплами нашего заказа
    var orderCoast = [(name: String, coast: Int)]()
    ///  ссегментед контрол
    private lazy var segmentControl = UISegmentedControl()
    /// лейбл - модификация
    private lazy var modifireLabel = UILabel()
    /// лейбл - цена
    private lazy var priceLabel = UILabel()
    /// кнопка переход на следующий экран
    private lazy var orderButton = UniversalButton()
    /// дефоллтная цена кофе
    private var price = 100
    
    // MARK: - Life cicly
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNavBar()
        setupUi()
    }
    
    // MARK: - private Methods
    
    /// настройка навигейшина
    private func configurationNavBar() {
        UIBarButtonItem.appearance().tintColor = UIColor.black
        view.addSubview(topCustomView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .done,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "paperplane.fill"),
            style: .done,
            target: self,
            action: #selector(activityButton)
        )
    }
    
    /// кладем элеменнты на экран
    private func setupUi() {
        view.backgroundColor = .white
        topCustomView.addSubview(backButtonBackgroundView)
        topCustomView.addSubview(itemImage)
        createLabel(label: modifireLabel, lineX: 16, lineY: 432, title: "Модификация")
        createLabel(label: priceLabel, lineX: 16, lineY: 669, title: "Цѣна - \(price) руб")
        orderMethod()
        createSegmendControll()
        emptyView(title: "Обжарка", lineX: 15)
        emptyView(title: "Дополнительные /n ингредіенты", lineX: 195)
    }
    
    /// создание лейблов
    private func createLabel(label: UILabel, lineX: Int, lineY: Int, title: String, fontSize: CGFloat = 16) {
        label.frame = CGRect(x: lineX, y: lineY, width: 345, height: 31)
        label.text = title
        label.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        priceLabel.textAlignment = .right
        view.addSubview(label)
    }
    
    /// создание сегмент контрала
    private func createSegmendControll() {
        segmentControl = UISegmentedControl(items: menyItem)
        segmentControl.frame = .init(x: 16, y: 368, width: view.frame.width - 32, height: 44)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(selectedItemSegmentControl), for: .valueChanged)
        view.addSubview(segmentControl)
    }
    
    /// создание кнопки
    private func orderMethod() {
        orderButton.center.x = view.center.x
        orderButton.setTitle("Заказать", for: .normal)
        orderButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        view.addSubview(orderButton)
    }
    
    /// Заглушки
    private func emptyView(title: String, lineX: Int) {
        let button = UIButton()
        button.frame = .init(x: lineX, y: 482, width: 165, height: 165)
        button.backgroundColor = #colorLiteral(red: 0.9686273932, green: 0.9686273932, blue: 0.9686273932, alpha: 1)
        button.addTarget(self, action: #selector(orderDetailUp), for: .touchUpInside)
        view.addSubview(button)
    }
    
    /// выбор селектора ссегмента
    @objc private func selectedItemSegmentControl() {
        let segmentIndex = segmentControl.selectedSegmentIndex
        itemImage.image = imageArray[segmentIndex]
    }
    
    /// открываем экран с выбором дополнительных ингридиентов и кладем в нас масссив
    @objc private func orderDetailUp() {
        let orderVC = MenuItemIngridientsConfigurationViewController()
        orderVC.closure = { [weak self] item in
            self?.orderCoast = item
            self?.orderCoast.forEach { _, coast in
                self?.price += coast
            }
            guard let coast = self?.price else { return }
            self?.priceLabel.text = "Цѣна - \(coast) руб"
        }
        present(orderVC, animated: true)
    }
    
    /// метод дляя перехода на общий чек
    @objc private func tappedButton() {
        let itemCofe = (name: menyItem[segmentControl.numberOfSegments - 1], coast: 100)
        orderCoast.insert(itemCofe, at: 0)
        let orderConfirmation = OrderConfirmationViewController()
        /// передаем orderCoast
    }
    
    @objc private func activityButton() {
        let shareContent = ["Лови промокод roadmaplove на 50 отжиманий"]
        let activityController = UIActivityViewController(
            activityItems: shareContent,
            applicationActivities: nil
        )
        present(activityController, animated: true, completion: nil)
    }
}
