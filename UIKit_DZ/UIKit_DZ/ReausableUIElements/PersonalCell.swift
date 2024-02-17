// PersonalCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка длля экрана с персональными данными
final class PersonalCell: UIView {
    // MARK: - Visual Components

    var iconCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    var titleCellLabel: UILabel = {
        let title = UILabel()
        title.font = .verdana?.withSize(16)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    var dividerView: UIView = {
        var divider = UIView()
        divider.backgroundColor = .systemGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func makeCell() {
        addSubviews(iconCell)
        addSubviews(titleCellLabel)
        addSubviews(dividerView)
        makeAnchor()
    }

    private func makeAnchor() {
        makeAnchorIconCell()
        makeTitleCellLabel()
        makeDividerView()
    }
}

// MARK: - Setup Anchor

extension PersonalCell {
    private func makeAnchorIconCell() {
        iconCell.topAnchor.constraint(equalTo: topAnchor, constant: 3).isActive = true
        iconCell.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        iconCell.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    private func makeTitleCellLabel() {
        titleCellLabel.centerYAnchor.constraint(equalTo: iconCell.centerYAnchor).isActive = true
        titleCellLabel.leadingAnchor.constraint(equalTo: iconCell.trailingAnchor, constant: 16).isActive = true
    }

    private func makeDividerView() {
        dividerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        dividerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dividerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
