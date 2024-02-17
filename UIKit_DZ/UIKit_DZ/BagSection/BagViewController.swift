// BagViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// tixomark
/// Экран корзины пользователя
final class BagViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Корзина"
        static let totalCostText = "Оформить заказ - "
        static let currency = " ₽"
    }

    // MARK: - Visual Components

    private let placeholderView = BagBackgroundPlaceholder()
    private var bagItemViews: [BagItemView] = [] {
        didSet {
            placeholderView.isHidden = !bagItemViews.isEmpty
            updateSubmissionButton()
        }
    }

    private let submissionButton = SubmissionButton()

    // MARK: - Public Properties

    var cart = Cart()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTable()
    }

    private func configureUI() {
        title = Constants.titleText
        view.backgroundColor = .systemBackground
        view.addSubviews(submissionButton, placeholderView)
        updateSubmissionButton()
        reloadTable()
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: submissionButton, placeholderView)
        [
            placeholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            submissionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submissionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submissionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -34)
        ].activate()
    }

    private func reloadTable() {
        let numberOfItemsInCart = cart.items.filter(\.isInCart).count
        let diff = numberOfItemsInCart - bagItemViews.count

        switch diff {
        case abs(diff):
            for _ in 0 ..< abs(diff) {
                addItem()
            }
        default:
            for _ in 0 ..< abs(diff) {
                removeItem()
            }
        }

        var lastUpdatedBagItemViewIndex = 0
        for (index, item) in cart.items.enumerated() where item.isInCart {
            let bagItemView = bagItemViews[lastUpdatedBagItemViewIndex]
            bagItemView.setCost(item.price)
            bagItemView.setSize(item.size ?? 37)
            bagItemView.setImage(item.image)
            bagItemView.toggleCartIcon(to: item.isInCart)
            bagItemView.setAmount(item.amount)
            bagItemView.tag = index
            lastUpdatedBagItemViewIndex += 1
        }
    }

    private func removeItem() {
        let removedItem = bagItemViews.removeLast()
        removedItem.removeFromSuperview()
    }

    private func addItem() {
        let itemView = BagItemView()
        itemView.delegate = self
        bagItemViews.append(itemView)
        view.addSubview(itemView)
        itemView.translatesAutoresizingMaskIntoConstraints = false

        if bagItemViews.count == 1 {
            itemView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).activate()
        } else {
            let currentLastItemView = bagItemViews[bagItemViews.count - 2]
            itemView.topAnchor.constraint(equalTo: currentLastItemView.bottomAnchor, constant: 30).activate()
        }
        [
            itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ].activate()
    }

    private func updateSubmissionButton() {
        submissionButton.isHidden = bagItemViews.isEmpty
        if !submissionButton.isHidden {
            let newButtonTitle = Constants.totalCostText + "\(cart.cartCost)" + Constants.currency
            submissionButton.setTitle(newButtonTitle, for: .normal)
        }
    }

    @objc private func didTapOrderButton() {
        submissionButton.isHidden.toggle()
    }
}

/// Получение уведомлений об изменениях в карточке товара - назатие кнопки корзины, измененеи размера, изменение
/// количества
extension BagViewController: BagItemViewDelegate {
    func cartButtonIn(_ bagItemView: BagItemView, switchedTo value: Bool) {
        guard value == false else { return }
        let itemIndex = bagItemView.tag
        cart.items[itemIndex].isInCart = false
        cart.items[itemIndex].amount = 0
        reloadTable()
    }

    func amountDidChangeIn(_ bagItemView: BagItemView, to value: Int) {
        let price = cart.items[bagItemView.tag].price
        bagItemView.setCost(price * value)
        cart.items[bagItemView.tag].amount = value
        updateSubmissionButton()
    }

    func sizeDidChangeIn(_ gabItemView: BagItemView, to value: Int) {
        cart.items[gabItemView.tag].size = value
    }
}
