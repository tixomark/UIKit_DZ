// MenuItemModificationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол обьекта выступающего в качестве источника данных для данного контроллера
protocol MenuItemModificationDataSource: AnyObject {
    /// Спрашвает сколько ячеек должно быть в представлении
    func numberOfItemsIn(_ menuItemModification: MenuItemModificationViewController) -> Int
    /// Запрашивает текст для ячейки с определенным индексом
    func menuItemModification(_ menuItemModification: MenuItemModificationViewController, titleForItemAt index: Int)
        -> String?
    /// Запрашивает изображение для ячейки с определенным индексом
    func menuItemModification(_ menuItemModification: MenuItemModificationViewController, imageForItemAt index: Int)
        -> UIImage?
}

/// Протокол обьекта выступающего в качестве делегата для данного контроллера
protocol MenuItemModificationDelegate: AnyObject {
    /// Срабатывает при изменении выбора элемента и передает индекс выбранного элемента
    func menuItemModification(_ menuItemModification: MenuItemModificationViewController, didSelectItemAt index: Int)
}

// tixomark
/// Класс предоставляет визуальный интерфейс для выбора одного значения из множества
final class MenuItemModificationViewController: UIViewController {
    // MARK: - Public Properties

    weak var datasource: MenuItemModificationDataSource?
    weak var delegate: MenuItemModificationDelegate?

    // MARK: - Private Properties

    /// Кнопка закрытия
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(.xIcon), for: .normal)
        button.frame.size = CGSize(width: 14, height: 14)
        button.frame.origin = CGPoint(x: 20, y: 26)
        return button
    }()

    /// Заголовок контроллера
    private let headerView: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 320, height: 30)
        label.frame.origin = CGPoint(x: 20, y: 40)

        label.textColor = .black
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    /// Индекс выбранного элемента
    private var selectedItemIndex: Int?

    /// Массив всех элементов контроллера
    private var items: [OneItemView] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: - Public Methods

    /// Устанавливает тайтл для данного контроллера
    func setTitle(_ title: String) {
        headerView.text = title
    }

    // MARK: - Private Methods

    private func setUpUI() {
        loadItems()
        view.backgroundColor = .systemBackground
        view.addSubviews(headerView, closeButton)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnView(_:)))
        view.addGestureRecognizer(tapGesture)

        closeButton.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
    }

    /// На основе данных из датасурса строит и заполняет сетку представлений.
    private func loadItems() {
        guard let numberOfItems = datasource?.numberOfItemsIn(self) else { return }

        for index in 0 ..< numberOfItems {
            let view = OneItemView(frame: .zero)
            let image = datasource?.menuItemModification(self, imageForItemAt: index)
            let title = datasource?.menuItemModification(self, titleForItemAt: index)
            view.setImage(image)
            view.setTitle(title)

            let isEven = (index % 2 == 0)
            let originX = isEven ? 15 : 195
            let originY = 102 + (index / 2) * (165 + 15)
            view.frame.origin = CGPoint(x: originX, y: originY)

            items.append(view)
        }
        view.addSubviews(items)
    }

    /// При нажатии на вью констроллера проверяет куда попало нажатие.
    @objc private func didTapOnView(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: view)
        for (index, item) in items.enumerated() where index != selectedItemIndex {
            // Если нажатие попало в каой-то из айтемов, делает его выбранным и передает его индекс делегату
            if item.frame.contains(touchLocation) {
                if let selectedItemIndex {
                    items[selectedItemIndex].setState(to: .normal)
                }
                selectedItemIndex = index
                items[index].setState(to: .highlited)
                delegate?.menuItemModification(self, didSelectItemAt: index)
            }
        }
    }

    @objc private func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
