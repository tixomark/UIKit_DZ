// MenuItemCofigurationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с конфигарцией напитка
final class MenuItemCofigurationViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let modifireLabel = "Модификация"
        static let promoCode = "Лови промокод roadmaplove на 50 отжиманий"
        static let orderButtonTitle = "Заказать"
        static let menuItems = ["Американо", "Капучино", "Латте"]
        static let images: [UIImage] = [.americano, .capuchino, .latte]
    }

    // MARK: - visual components

    private lazy var topCustomView: UIView = {
        let customView = UIView()
        customView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 346)
        customView.backgroundColor = #colorLiteral(red: 0.9428322315, green: 0.8812621236, blue: 0.8162202239, alpha: 1)
        customView.layer.cornerRadius = 20
        customView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return customView
    }()

    private lazy var backButtonBackgroundView: UIView = {
        let customView = UIView()
        customView.frame = .init(x: 7, y: 50, width: 44, height: 44)
        customView.backgroundColor = #colorLiteral(red: 0.9217587709, green: 0.9660443664, blue: 0.969683826, alpha: 1)
        customView.layer.cornerRadius = 20
        return customView
    }()

    private lazy var itemImage: UIImageView = {
        let product = UIImageView()
        product.frame = .init(x: 0, y: 0, width: 150, height: 150)
        product.center.x = topCustomView.center.x
        product.center.y = topCustomView.center.y
        product.image = UIImage(named: "americano")
        return product
    }()

    private lazy var segmentControl = UISegmentedControl()
    private lazy var modifireLabel = UILabel()
    private lazy var priceLabel = UILabel()
    private lazy var orderButton = SubmissionButton()

    // MARK: - Public Properties

    private var price = 100
    private var orderCoast = [(name: String, coast: Int)]()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNavBar()
        configureUi()
    }

    // MARK: - Private Methods

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
            action: #selector(activityButtonTapped)
        )
    }

    private func configureUi() {
        view.backgroundColor = .white
        topCustomView.addSubview(backButtonBackgroundView)
        topCustomView.addSubview(itemImage)
        makeLabel(label: modifireLabel, lineX: 16, lineY: 432, title: Constants.modifireLabel)
        makeLabel(label: priceLabel, lineX: 16, lineY: 669, title: "Цѣна - \(price) руб")
        makeOrderMethod()
        makeSegmendControll()
        emptyView(title: "Обжарка", lineX: 15)
        emptyView(title: "Дополнительные /n ингредіенты", lineX: 195)
    }

    private func makeLabel(label: UILabel, lineX: Int, lineY: Int, title: String, fontSize: CGFloat = 16) {
        label.frame = CGRect(x: lineX, y: lineY, width: 345, height: 31)
        label.text = title
        label.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        priceLabel.textAlignment = .right
        view.addSubview(label)
    }

    private func makeSegmendControll() {
        segmentControl = UISegmentedControl(items: Constants.menuItems)
        segmentControl.frame = .init(x: 16, y: 368, width: view.frame.width - 32, height: 44)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedControlDidChangeSelection), for: .valueChanged)
        view.addSubview(segmentControl)
    }

    private func makeOrderMethod() {
        orderButton.center.x = view.center.x
        orderButton.setTitle(Constants.orderButtonTitle, for: .normal)
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        view.addSubview(orderButton)
    }

    /// Заглушки
    private func emptyView(title: String, lineX: Int) {
        let button = UIButton()
        button.frame = .init(x: lineX, y: 482, width: 165, height: 165)
        button.backgroundColor = #colorLiteral(red: 0.9686273932, green: 0.9686273932, blue: 0.9686273932, alpha: 1)
        button.addTarget(self, action: #selector(presentOrderDetailViewController), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func segmentedControlDidChangeSelection() {
        let segmentIndex = segmentControl.selectedSegmentIndex
        itemImage.image = Constants.images[segmentIndex]
    }

    @objc private func presentOrderDetailViewController() {
        let orderViewController = MenuItemIngridientsConfigurationViewController()
        orderViewController.closure = { [weak self] item in
            self?.orderCoast = item
            self?.orderCoast.forEach { _, coast in
                self?.price += coast
            }
            guard let coast = self?.price else { return }
            self?.priceLabel.text = "Цѣна - \(coast) руб"
        }
        present(orderViewController, animated: true)
    }

    @objc private func orderButtonTapped() {
        let itemCofe = (name: Constants.menuItems[segmentControl.numberOfSegments - 1], coast: 100)
        orderCoast.insert(itemCofe, at: 0)
        let orderConfirmation = OrderConfirmationViewController()
        /// передаем orderCoast
    }

    @objc private func activityButtonTapped() {
        let shareContent = [Constants.promoCode]
        let activityController = UIActivityViewController(
            activityItems: shareContent,
            applicationActivities: nil
        )
        present(activityController, animated: true, completion: nil)
    }
}
