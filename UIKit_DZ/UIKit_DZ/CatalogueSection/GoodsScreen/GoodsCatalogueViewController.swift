// GoodsCatalogueViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// tixomark
/// Список товаров секции основного каталога
final class GoodsCatalogueViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Обувь"
        static let currencySigh = "\u{20BD}"

        static let goods: [(image: UIImage, cost: Int, isInCart: Bool)] = [
            (image: .shoeImage6, cost: 2250, isInCart: false),
            (image: .shoeImage7, cost: 4250, isInCart: false),
            (image: .shoeImage8, cost: 5750, isInCart: false),
            (image: .shoeImage9, cost: 3500, isInCart: false),
            (image: .shoeImage10, cost: 5750, isInCart: false)
        ]
    }

    // MARK: - Visual Components

    private lazy var goodsCatalogueItems: [GoodsCatalogueItemView] = {
        var goods: [GoodsCatalogueItemView] = []
        for (index, good) in Constants.goods.enumerated() {
            let view = GoodsCatalogueItemView()
            view.setCostLabel("\(good.cost) " + Constants.currencySigh)
            view.setImage(good.image)
            view.delegate = self
            view.tag = index
            goods.append(view)
        }
        return goods
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }
    
    // MARK: - Private Methods

    private func configureUI() {
        title = Constants.titleText
        view.backgroundColor = .systemBackground
        view.addSubviews(goodsCatalogueItems)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: goodsCatalogueItems)

        for (index, item) in goodsCatalogueItems.enumerated() {
            switch index {
            case 0, 1:
                item.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 33)
                    .isActive = true
            default:
                item.topAnchor.constraint(equalTo: goodsCatalogueItems[index - 2].bottomAnchor, constant: 16)
                    .isActive = true
            }
            
            if index % 2 == 0 {
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            } else {
                [
                    item.leadingAnchor.constraint(equalTo: goodsCatalogueItems[index - 1].trailingAnchor, constant: 21),
                    item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                ].activate()
            }

            item.widthAnchor.constraint(equalTo: goodsCatalogueItems[0].widthAnchor).isActive = true
            item.heightAnchor.constraint(equalTo: item.widthAnchor).isActive = true
        }
    }
}

extension GoodsCatalogueViewController: GoodsCatalogueItemViewDelegate {
    func didTapCartButtonIn(_ goodsCatalogueItemView: GoodsCatalogueItemView) {
        
        
    }
}
