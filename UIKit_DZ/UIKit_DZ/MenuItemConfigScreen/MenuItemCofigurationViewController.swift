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
        static let modifireTitle = "Дополнительные \n ингредіенты"
        static let roastingTitle: [String] = ["Темная \n обжарка", "Свѣтлая \n обжарка"]
        static let menuItems = ["Американо", "Капучино", "Латте"]
        static let menuItemIngridientTitle = "Уточните обжарку зеренъ"
        static let images: [UIImage] = [.americano, .capuchino, .latte]
        static let roastingImages: [UIImage] = [.darkRoasting, .liteRoasting]
        static let isIngridient: [UIImage] = [.plusIngridient, .doneIngridient]
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

    private lazy var roastingTypeView: OneItemView = {
        let cell = OneItemView()
        cell.frame.origin = CGPoint(x: 15, y: 482)
        let gestoreRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapRostingSelectionButton)
        )
        cell.addGestureRecognizer(gestoreRecognizer)
        cell.setImage(.darkRoasting)
        cell.setTitle(Constants.roastingTitle[0])
        return cell
    }()

    private lazy var modifireView: OneItemView = {
        let cell = OneItemView()
        cell.frame.origin = CGPoint(x: 195, y: 482)
        let gestoreRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(presentOrderDetailViewController)
        )
        cell.addGestureRecognizer(gestoreRecognizer)
        cell.setImage(Constants.isIngridient[0])
        cell.setTitle(Constants.modifireTitle)
        cell.setSizeImage(29, 29)
        return cell
    }()

    private lazy var segmentControl = UISegmentedControl()
    private lazy var modifireLabel = UILabel()
    private lazy var priceLabel = UILabel()
    private lazy var orderButton = SubmissionButton()

    // MARK: - Private Properties

    private var price = 100
    private var orderCoast = [(name: String, cost: Int)]()
    private var rostingTypeIndex = 0

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
        view.addSubview(roastingTypeView)
        view.addSubview(modifireView)
        makeLabel(label: modifireLabel, lineX: 16, lineY: 432, title: Constants.modifireLabel)
        makeLabel(label: priceLabel, lineX: 16, lineY: 669, title: "Цѣна - \(price) руб")
        makeOrderMethod()
        makeSegmendControll()
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

    @objc private func didTapRostingSelectionButton() {
        let menuItemModification = MenuItemModificationViewController()
        menuItemModification.delegate = self
        menuItemModification.datasource = self
        menuItemModification.setInitialSelectedItemIndex(rostingTypeIndex)
        menuItemModification.setTitle(Constants.menuItemIngridientTitle)
        present(menuItemModification, animated: true)
    }

    @objc private func segmentedControlDidChangeSelection() {
        let segmentIndex = segmentControl.selectedSegmentIndex
        itemImage.image = Constants.images[segmentIndex]
    }

    @objc private func presentOrderDetailViewController() {
        let orderViewController = MenuItemIngridientsConfigurationViewController()
        orderViewController.closure = { [weak self] item in
            self?.orderCoast = item
            self?.modifireView.setImage(Constants.isIngridient[item.isEmpty ? 0 : 1])
            var sum = 100
            self?.orderCoast.forEach { _, cost in
                sum += cost
            }
            self?.price = sum
            guard let coast = self?.price else { return }
            self?.priceLabel.text = "Цѣна - \(coast) руб"
        }
        present(orderViewController, animated: true)
    }

    @objc private func orderButtonTapped() {
        let itemCofe = (name: Constants.menuItems[segmentControl.numberOfSegments - 1], cost: 100)
        orderCoast.insert(itemCofe, at: 0)
        let orderConfirmation = OrderDetailsViewController()
        orderConfirmation.orderPositions = orderCoast
        orderConfirmation.completion = { [weak self] in
            self?.navigationController?.pushViewController(OrderConfirmationViewController(), animated: true)
        }
        present(orderConfirmation, animated: true)
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

// MARK: - MenuItemModificationDelegate

extension MenuItemCofigurationViewController: MenuItemModificationDelegate {
    func menuItemModification(_ menuItemModification: MenuItemModificationViewController, didSelectItemAt index: Int) {
        roastingTypeView.setImage(Constants.roastingImages[index])
        roastingTypeView.setTitle(Constants.roastingTitle[index])
        rostingTypeIndex = index
    }
}

// MARK: - MenuItemModificationDataSource

extension MenuItemCofigurationViewController: MenuItemModificationDataSource {
    func numberOfItemsIn(_ menuItemModification: MenuItemModificationViewController) -> Int {
        Constants.roastingTitle.count
    }

    func menuItemModification(
        _ menuItemModification: MenuItemModificationViewController,
        titleForItemAt index: Int
    ) -> String? {
        Constants.roastingTitle[index]
    }

    func menuItemModification(
        _ menuItemModification: MenuItemModificationViewController,
        imageForItemAt index: Int
    ) -> UIImage? {
        Constants.roastingImages[index]
    }
}
