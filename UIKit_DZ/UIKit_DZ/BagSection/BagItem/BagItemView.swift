// BagItemView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol BagItemViewDelegate: AnyObject {
    /// Уведомляет делегат о нажатии кнопки корзины в карточке товара
    func cartButtonIn(_ bagItemView: BagItemView, switchedTo value: Bool)
    /// Уведомляет делегат об изменении значения количества товара
    func amountDidChangeIn(_ bagItemView: BagItemView, to value: Int)
    /// Уведомляет делегат об изменении выбранного размера товара
    func sizeDidChangeIn(_ gabItemView: BagItemView, to value: Int)
}

/// Представляет ячейку с товаром в корзине пользователя
final class BagItemView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Женские ботинки"
        static let amountText = "Количество"
        static let sizeText = "Размер"
        static let costText = "Цена"
        static let currencySigh = "\u{20BD}"
    }

    // MARK: - Visual Components

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .verdana?.withSize(12)
        label.textAlignment = .left
        label.text = Constants.titleText
        return label
    }()

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .verdana?.withSize(12)
        label.textAlignment = .left
        label.text = Constants.amountText
        return label
    }()

    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .verdana?.withSize(12)
        label.textAlignment = .left
        label.text = Constants.sizeText
        return label
    }()

    private let costTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .verdana?.withSize(12)
        label.textAlignment = .left
        label.text = Constants.costText
        return label
    }()

    private let costLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .verdanaBold?.withSize(10)
        label.textAlignment = .right
        return label
    }()

    private lazy var goodItemView: GoodItemView = {
        let view = GoodItemView()
        view.delegate = self
        return view
    }()

    private lazy var amountStepper: StepperView = {
        let stepper = StepperView()
        stepper.delegate = self
        return stepper
    }()

    private lazy var sizeSelectorView: SizeSelectorView = {
        let view = SizeSelectorView()
        view.delegate = self
        view.isUserInteractionEnabled = true
        return view
    }()

    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 100, height: 157)
    }

    weak var delegate: BagItemViewDelegate?

    // MARK: - Private Properties

    private var isCartButtonActivated = false

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func setImage(_ image: UIImage) {
        goodItemView.setImage(image)
    }

    func setCost(_ text: Int) {
        costLabel.text = "\(text)" + Constants.currencySigh
    }

    func setAmount(_ amount: Int) {
        amountStepper.setAmount(amount)
    }

    func setSize(_ size: Int) {
        sizeSelectorView.setSelectedSize(size)
    }

    func toggleCartIcon(to value: Bool) {
        goodItemView.setCartButtonHighlition(to: value)
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(nameLabel, amountLabel, sizeLabel, costTitleLabel, costLabel)
        addSubviews(goodItemView, amountStepper, sizeSelectorView)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: subviews)
        [
            goodItemView.leadingAnchor.constraint(equalTo: leadingAnchor),
            goodItemView.topAnchor.constraint(equalTo: topAnchor, constant: -18),
            goodItemView.bottomAnchor.constraint(equalTo: bottomAnchor),
            goodItemView.widthAnchor.constraint(equalTo: goodItemView.heightAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: goodItemView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),

            amountLabel.leadingAnchor.constraint(equalTo: goodItemView.trailingAnchor, constant: 16),
            amountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),

            amountStepper.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 10),
            amountStepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            amountStepper.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            amountStepper.heightAnchor.constraint(equalToConstant: 15),

            sizeLabel.leadingAnchor.constraint(equalTo: goodItemView.trailingAnchor, constant: 16),
            sizeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            sizeLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 12),

            sizeSelectorView.leadingAnchor.constraint(equalTo: goodItemView.trailingAnchor, constant: 22),
            sizeSelectorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            sizeSelectorView.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 10),

            costTitleLabel.leadingAnchor.constraint(equalTo: goodItemView.trailingAnchor, constant: 16),
            costTitleLabel.topAnchor.constraint(equalTo: sizeSelectorView.bottomAnchor, constant: 7),

            costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            costLabel.topAnchor.constraint(equalTo: sizeSelectorView.bottomAnchor, constant: 9),
        ].activate()
    }
}

///  Получение увадомлений о нажатии кнопки корзины
extension BagItemView: GoodItemViewDelegate {
    func cartButtonSelectionStateIn(_ goodItemView: GoodItemView, changedTo value: Bool) {
        delegate?.cartButtonIn(self, switchedTo: value)
    }
}

/// Получение уведомлений об изменении значения степпера
extension BagItemView: StepperViewDelegate {
    func valueDidChange(to value: Int) {
        delegate?.amountDidChangeIn(self, to: value)
    }
}

/// Получение уведомлений об изменении значения выбора размера
extension BagItemView: SizeSelectorViewDelegate {
    func didSelect(_ size: Int) {
        delegate?.sizeDidChangeIn(self, to: size)
    }
}
