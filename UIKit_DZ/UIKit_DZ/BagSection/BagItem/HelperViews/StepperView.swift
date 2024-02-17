// StepperView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol StepperViewDelegate: AnyObject {
    /// Метод, уведомляющий об изменении значения степпера
    func valueDidChange(to value: Int)
}

/// Степпер итераций по значениям на еденицу за раз
final class StepperView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let minusImage = UIImage(systemName: "minus")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        static let plusImage = UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    }

    // MARK: - Public Properties

    weak var delegate: StepperViewDelegate?

    override var intrinsicContentSize: CGSize {
        CGSize(width: 53, height: 15)
    }

    // MARK: - Private Properties

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .verdana?.withSize(12)
        label.textAlignment = .center
        return label
    }()

    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.minusImage, for: .normal)
        button.backgroundColor = .shallowPink
        button.layer.cornerRadius = 7.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var plusButton: UIButton = {
        let button = UIButton()

        button.setImage(Constants.plusImage, for: .normal)
        button.backgroundColor = .shallowPink
        button.layer.cornerRadius = 7.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private var value = 1

    init(initialValue: Int = 1) {
        value = initialValue
        super.init(frame: .zero)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        value = 1
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func setAmount(_ amount: Int) {
        value = amount
        amountLabel.text = "\(value)"
    }

    // MARK: - Private Methods

    private func configureUI() {
        amountLabel.text = "\(value)"
        addSubviews(minusButton, amountLabel, plusButton)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: minusButton, amountLabel, plusButton)
        [
            minusButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            minusButton.topAnchor.constraint(equalTo: topAnchor),
            minusButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            minusButton.widthAnchor.constraint(equalTo: minusButton.heightAnchor),

            amountLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 3),
            amountLabel.widthAnchor.constraint(equalToConstant: 19),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            plusButton.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 3),
            plusButton.topAnchor.constraint(equalTo: topAnchor),
            plusButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            plusButton.heightAnchor.constraint(equalTo: minusButton.heightAnchor),
            plusButton.heightAnchor.constraint(equalTo: plusButton.widthAnchor)
        ].activate()
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        switch sender {
        case minusButton:
            value = max(1, value - 1)
        case plusButton:
            value += 1
        default:
            break
        }
        amountLabel.text = "\(value)"
        delegate?.valueDidChange(to: value)
    }
}
