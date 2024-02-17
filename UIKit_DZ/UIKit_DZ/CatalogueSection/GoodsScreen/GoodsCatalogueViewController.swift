// GoodsCatalogueViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// tixomark
/// Экран со списком товаров секции основного каталога
final class GoodsCatalogueViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Обувь"
    }

    // MARK: - Visual Components

    private lazy var goodItemViews: [GoodItemView] = {
        var itemViews: [GoodItemView] = []
        guard let cart else { return itemViews }

        for (index, good) in cart.items.enumerated() {
            let view = GoodItemView(isCostLabelHidden: false)
            view.configure(with: good)
            view.delegate = self
            view.tag = index
            itemViews.append(view)
        }
        return itemViews
    }()

    // MARK: - Public Properties

    var cart: Cart?
    var selectedGoogIndex: Int?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyUpdateFromModelIfThereAreAny()
    }

    // MARK: - Private Methods

    private func configureUI() {
        title = Constants.titleText
        view.backgroundColor = .systemBackground
        view.addSubviews(goodItemViews)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: goodItemViews)

        for (index, itemView) in goodItemViews.enumerated() {
            switch index {
            case 0, 1:
                itemView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 33).activate()
            default:
                let viewOnTop = goodItemViews[index - 2]
                itemView.topAnchor.constraint(equalTo: viewOnTop.bottomAnchor, constant: 16).activate()
            }

            if index % 2 == 0 {
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).activate()
            } else {
                let viewInFront = goodItemViews[index - 1]
                [
                    itemView.leadingAnchor.constraint(equalTo: viewInFront.trailingAnchor, constant: 21),
                    itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                ].activate()
            }
            itemView.widthAnchor.constraint(equalTo: goodItemViews[0].widthAnchor).activate()
            itemView.heightAnchor.constraint(equalTo: itemView.widthAnchor).activate()
        }
    }

    private func applyUpdateFromModelIfThereAreAny() {
        guard let cart else { return }
        for (index, good) in cart.items.enumerated() {
            goodItemViews[index].setCartButtonHighlition(to: good.isInCart)
        }
    }
}

/// Обрабатывает нажатия на иконки корзинок у карточек товаров
extension GoodsCatalogueViewController: GoodItemViewDelegate {
    func cartButtonSelectionStateIn(_ goodItemView: GoodItemView, changedTo value: Bool) {
        let goodIndex = goodItemView.tag
        if value == true {
            let chooseSizeVC = ChooseSizeViewController()
            chooseSizeVC.delegate = self
            present(chooseSizeVC, animated: true)
            selectedGoogIndex = goodIndex
        } else {
            guard let cart else { return }
            cart.items[goodIndex].isInCart = false
            cart.items[goodIndex].amount = 0
            goodItemViews[goodIndex].setCartButtonHighlition(to: false)
        }
    }
}

/// Обрабатывает нотификации о выборе размера товара
extension GoodsCatalogueViewController: ChooseSizeViewControllerDelegate {
    func didSelect(_ size: Int) {
        guard let selectedGoogIndex, let cart else { return }
        cart.items[selectedGoogIndex].size = size
        cart.items[selectedGoogIndex].isInCart = true
        cart.items[selectedGoogIndex].amount += 1
    }
}
