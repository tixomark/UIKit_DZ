// HeaderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Хедер секций для таблицы нотификаций
final class HeaderView: UITableViewHeaderFooterView {
    // MARK: - Visual Components

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = .verdanaBold?.withSize(14)
        label.textAlignment = .left
        return label
    }()

    // MARK: - Life Cycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func setTitle(_ text: String?) {
        headerLabel.text = text
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubview(headerLabel)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: headerLabel)
        [
            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 17)
        ].activate()
    }
}
