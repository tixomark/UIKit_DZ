// GoodItemView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol GoodItemViewDelegate: AnyObject {
    /// Метод, уведомляющий об изменении выделения кнопки корзины
    func cartButtonSelectionStateIn(_ goodItemView: GoodItemView, changedTo value: Bool)
}

/// Ячейка товара содержащяя его изображение, название и цену
final class GoodItemView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let currencySigh = " \u{20BD}"
    }

    // MARK: - Visual Components

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let costLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .verdanaBold?.withSize(10)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()

    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(.cartIcon, for: .normal)
        button.setImage(.cartIcon, for: .highlighted)
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    weak var delegate: GoodItemViewDelegate?

    override var intrinsicContentSize: CGSize {
        CGSize(width: 100, height: 100)
    }

    // MARK: - Private Properties

    private(set) var isCartButtonHiglited = false

    // MARK: - Life Cycle

    init(isCostLabelHidden: Bool = true) {
        super.init(frame: .zero)
        costLabel.isHidden = isCostLabelHidden
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func setImage(_ image: UIImage?) {
        imageView.image = image
    }

    func configure(with bagItem: Cart.CartItem) {
        imageView.image = bagItem.image
        costLabel.text = "\(bagItem.price)" + Constants.currencySigh
        setCartButtonHighlition(to: bagItem.isInCart)
    }

    func setCartButtonHighlition(to isHighlited: Bool) {
        isCartButtonHiglited = isHighlited
        let cartButtonImage: UIImage = isCartButtonHiglited ? .cartIcon.withTintColor(.accentPink) : .cartIcon
        cartButton.setImage(cartButtonImage, for: .normal)
        cartButton.setImage(cartButtonImage, for: .highlighted)
    }

    // MARK: - Private Methods

    private func configureUI() {
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
        backgroundColor = .backgroundAccent

        addSubviews(cartButton, imageView, costLabel)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: cartButton, imageView, costLabel)
        [
            cartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            cartButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            cartButton.heightAnchor.constraint(equalToConstant: 20),
            cartButton.widthAnchor.constraint(equalTo: cartButton.heightAnchor),

            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 29),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -29),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 29),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -29),

            costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9),
            costLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ].activate()
    }

    @objc private func cartButtonTapped() {
        setCartButtonHighlition(to: !isCartButtonHiglited)
        delegate?.cartButtonSelectionStateIn(self, changedTo: isCartButtonHiglited)
    }
}
