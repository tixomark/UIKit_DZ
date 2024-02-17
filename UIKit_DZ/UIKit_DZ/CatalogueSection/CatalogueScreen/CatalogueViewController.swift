// CatalogueViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// tixomark
/// Экран содержащий каталог товаров магазина
final class CatalogueViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Каталог"
        static let personGroups = ["Женщинам", "Мужчинам", "Детям"]
        static let catalogueItemTitiles = ["Новинки", "Распродажа"]
        static let catalogueItemImages: [String: [UIImage]] = [
            personGroups[0]: [.shoeImage0, .shoeImage1],
            personGroups[1]: [.shoeImage2, .shoeImage3],
            personGroups[2]: [.shoeImage4, .shoeImage5]
        ]
        static let catalogueSectionItemTitles = ["Бренды", "Обувь", "Сумки"]
        static let catalogueSectionItemBrandsImage: UIImage = .brands
        static let catalogueSectionItemImages: [String: [UIImage]] = [
            personGroups[0]: [.womanShoe, .womanBag],
            personGroups[1]: [.manShoe, .manBag],
            personGroups[2]: [.childShoe, .childBag]
        ]
    }

    // MARK: - Visual Components

    private let leftCatalogueImage: CatalogueItemView = {
        let view = CatalogueItemView(labelPosition: .top)
        view.setTitle(Constants.catalogueItemTitiles[0])
        return view
    }()

    private let rightCatalogueImage: CatalogueItemView = {
        let view = CatalogueItemView(labelPosition: .bottom)
        view.setTitle(Constants.catalogueItemTitiles[1])
        return view
    }()

    private lazy var personGroupSegmentedControll: UISegmentedControl = {
        let controll = UISegmentedControl(items: Constants.personGroups)
        controll.selectedSegmentIndex = 0
        if let font = UIFont.verdanaBold?.withSize(12) {
            controll.setTitleTextAttributes([.font: font], for: .normal)
        }
        controll.addTarget(self, action: #selector(valueChangedIn(_:)), for: .valueChanged)
        return controll
    }()

    private lazy var catalogueSectionItems: [CatalogueSectionItemView] = {
        var array: [CatalogueSectionItemView] = []
        for catalogueSectionItemTitle in Constants.catalogueSectionItemTitles {
            let view = CatalogueSectionItemView()
            view.setTitle(catalogueSectionItemTitle)
            array.append(view)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(catalogueSectionItemTapped))
        array[1].addGestureRecognizer(tapGesture)
        return array
    }()

    // MARK: - Public Properties

    var shoes: Cart?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    private func configureUI() {
        title = Constants.titleText
        view.backgroundColor = .systemBackground

        let navigationTitleFont = UIFont.verdanaBold?.withSize(16) ?? .systemFont(ofSize: 16)
        navigationController?.navigationBar.titleTextAttributes = [.font: navigationTitleFont]

        valueChangedIn(personGroupSegmentedControll)
        catalogueSectionItems[0].setImage(Constants.catalogueSectionItemBrandsImage)

        view.addSubviews(personGroupSegmentedControll, leftCatalogueImage, rightCatalogueImage)
        view.addSubviews(catalogueSectionItems)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "")
        navigationItem.backBarButtonItem?.tintColor = .black

        configureNavigationItems()
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: view.subviews)

        [
            personGroupSegmentedControll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            personGroupSegmentedControll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            personGroupSegmentedControll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            personGroupSegmentedControll.heightAnchor.constraint(equalToConstant: 44),

            leftCatalogueImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leftCatalogueImage.topAnchor.constraint(equalTo: personGroupSegmentedControll.bottomAnchor, constant: 20),
            leftCatalogueImage.heightAnchor.constraint(equalTo: leftCatalogueImage.widthAnchor, multiplier: 3 / 4),

            rightCatalogueImage.leadingAnchor.constraint(equalTo: leftCatalogueImage.trailingAnchor, constant: 15),
            rightCatalogueImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rightCatalogueImage.topAnchor.constraint(equalTo: personGroupSegmentedControll.bottomAnchor, constant: 20),
            rightCatalogueImage.widthAnchor.constraint(equalTo: leftCatalogueImage.widthAnchor),
            rightCatalogueImage.heightAnchor.constraint(equalTo: leftCatalogueImage.heightAnchor),
        ].activate()

        for (index, view) in catalogueSectionItems.enumerated() {
            let topView = index == 0 ? leftCatalogueImage : catalogueSectionItems[index - 1]
            [
                view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                view.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            ].activate()
        }
    }

    private func configureNavigationItems() {
        let cameraItem = UIBarButtonItem(
            image: .cameraIcon.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(cameraItemTapped)
        )
        let qrScannerItem = UIBarButtonItem(image: .qrScanerIcon.withRenderingMode(.alwaysOriginal))
        navigationItem.setRightBarButtonItems([qrScannerItem, cameraItem], animated: false)
    }

    @objc private func valueChangedIn(_ sender: UISegmentedControl) {
        let segmentIndex = sender.selectedSegmentIndex
        let personGroup = Constants.personGroups[segmentIndex]

        leftCatalogueImage.setImage(Constants.catalogueItemImages[personGroup]?[0])
        rightCatalogueImage.setImage(Constants.catalogueItemImages[personGroup]?[1])

        for index in 1 ..< Constants.catalogueSectionItemTitles.count {
            catalogueSectionItems[index].setImage(Constants.catalogueSectionItemImages[personGroup]?[index - 1])
        }
    }

    @objc private func cameraItemTapped() {
        print("camera")
    }

    @objc private func catalogueSectionItemTapped() {
        let goodsVC = GoodsCatalogueViewController()
        goodsVC.cart = shoes
        navigationController?.pushViewController(goodsVC, animated: true)
    }
}
