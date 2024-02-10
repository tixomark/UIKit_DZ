// FormFieldView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Предвставление(поле формы для заполнения), содержашее аннотацию и текствое поле.
final class FormFieldView: UIView {
    // MARK: - Types

    /// Обозначает разные концигурации данного вью
    enum AccessoryType {
        /// Нет дополнительного элемента
        case none
        /// Дополнительный элемент - кнопка
        case button
    }

    // MARK: - Public Properties

    /// Заголовок
    let annotationLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold?.withSize(16)
        label.textAlignment = .left
        return label
    }()

    /// Текствовое поле
    let textField: UITextField = {
        let textField = UITextField()
        textField.font = .verdana?.withSize(14)
        return textField
    }()

    // MARK: - Private Properties

    /// Черта по нижней границе отображения
    private let bottomLine: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.opaqueSeparator.cgColor
        layer.frame.size.height = 1
        layer.masksToBounds = true
        return layer
    }()

    /// Опциональная кнопка в правой нижней части вью
    private(set) lazy var accessoryButton = UIButton()

    private var accessoryType: AccessoryType = .none

    // MARK: - Life Cycle

    init(accessoryType: AccessoryType = .none) {
        let size = CGSize(width: 0, height: 54)
        let frame = CGRect(origin: .zero, size: size)
        super.init(frame: frame)
        self.accessoryType = accessoryType
        setUpUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        calculateAndApplySubviewsFrames()
    }

    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return textField.resignFirstResponder()
    }

    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        return textField.becomeFirstResponder()
    }

    // MARK: - Private Methods

    private func setUpUI() {
        addSubviews(annotationLabel, textField)
        layer.addSublayer(bottomLine)

        if accessoryType == .button {
            addSubview(accessoryButton)
        }
    }

    /// Рассчитывает размеры и положения сабвью данного отображения. И распологает все сабвью соответственно.
    private func calculateAndApplySubviewsFrames() {
        let annotationLabelSize = CGSize(width: bounds.width, height: 19)
        annotationLabel.frame = CGRect(origin: .zero, size: annotationLabelSize)

        if accessoryType == .button {
            let acceessoryButtonSize = CGSize(width: 22, height: 15)
            let accessoryButtonOrigin = CGPoint(x: bounds.maxX - 22, y: annotationLabel.frame.maxY + 5)
            accessoryButton.frame = CGRect(origin: accessoryButtonOrigin, size: acceessoryButtonSize)
        }

        let textFieldOriginY = annotationLabel.frame.height + 10
        let accessoryButtonWidth = (accessoryType == .none ? 0 : accessoryButton.frame.width)
        let textFieldwidth = bounds.width - accessoryButtonWidth
        textField.frame = CGRect(x: 0, y: textFieldOriginY, width: textFieldwidth, height: 17)

        bottomLine.frame.origin = CGPoint(x: 0, y: bounds.maxY - 1)
        bottomLine.frame.size = CGSize(width: bounds.width, height: 1)
    }
}
