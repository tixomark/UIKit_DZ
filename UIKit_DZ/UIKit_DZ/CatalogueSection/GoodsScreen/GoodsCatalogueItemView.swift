// GoodsCatalogueItemView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol GoodsCatalogueItemViewDelegate: AnyObject {
    func didTapCartButtonIn(_ goodsCatalogueItemView: GoodsCatalogueItemView)
}

final class GoodsCatalogueItemView: UIView {
    // MARK: - Public Properties

    weak var delegate: GoodsCatalogueItemViewDelegate?

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

    override var intrinsicContentSize: CGSize {
        CGSize(width: 100, height: 100)
    }

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

    func setCostLabel(_ text: String?) {
        costLabel.text = text
    }

    func setImage(_ image: UIImage?) {
        imageView.image = image
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
        isCartButtonActivated.toggle()
        let cartButtonImage: UIImage = isCartButtonActivated ? .cartIcon.withTintColor(.accentPink) : .cartIcon
        cartButton.setImage(cartButtonImage, for: .normal)
        cartButton.setImage(cartButtonImage, for: .highlighted)

        delegate?.didTapCartButtonIn(self)
    }
}
