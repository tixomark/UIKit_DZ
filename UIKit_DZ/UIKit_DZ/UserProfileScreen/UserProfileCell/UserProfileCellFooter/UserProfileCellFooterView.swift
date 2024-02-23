// UserProfileCellFooterView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Футер содержащий функциональные кнопки управления профилем
final class UserProfileCellFooterView: UIView {
    private enum Constants {
        static let editText = "Изменить"
        static let shareText = "Поделиться профилем"
    }

    // MARK: - Private Properties

    private let editButton: ActionButton = {
        let button = ActionButton()
        button.setTitle(Constants.editText, for: .normal)
        return button
    }()

    private let shareButton: ActionButton = {
        let button = ActionButton()
        button.setTitle(Constants.shareText, for: .normal)
        return button
    }()

    private let addButton: ActionButton = {
        let button = ActionButton()
        button.setImage(.addUserIcon.withTintColor(.accent), for: .normal)
        return button
    }()

    // MARK: - Life Cycle

    init() {
        super.init(frame: .zero)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(editButton, shareButton, addButton)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: editButton, shareButton, addButton)
        configureEditButtonLayout()
        configureShareButtonLayout()
        configureAddButtonLayout()
    }

    private func configureEditButtonLayout() {
        [
            editButton.topAnchor.constraint(equalTo: topAnchor),
            editButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            editButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            editButton.widthAnchor.constraint(equalTo: shareButton.widthAnchor)
        ].activate()
    }

    private func configureShareButtonLayout() {
        [
            shareButton.topAnchor.constraint(equalTo: topAnchor),
            shareButton.leadingAnchor.constraint(equalTo: editButton.trailingAnchor, constant: 5),
            shareButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ].activate()
    }

    private func configureAddButtonLayout() {
        [
            addButton.topAnchor.constraint(equalTo: topAnchor),
            addButton.leadingAnchor.constraint(equalTo: shareButton.trailingAnchor, constant: 5),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ].activate()
    }
}
