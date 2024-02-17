// SizeView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с текстовым полем и границей снизу
final class SizeView: UIView {
    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 20, height: 27)
    }

    // MARK: - Private Properties

    private let label: UILabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(16)
        label.textAlignment = .left
        return label
    }()

    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        return view
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func setTitle(_ text: String?) {
        label.text = text
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(label, bottomLine)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: subviews)
        [
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),

            bottomLine.heightAnchor.constraint(equalToConstant: 1),
            bottomLine.widthAnchor.constraint(equalTo: widthAnchor),
            bottomLine.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].activate()
    }
}
