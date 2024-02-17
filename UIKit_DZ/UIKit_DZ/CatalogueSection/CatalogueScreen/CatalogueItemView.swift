// CatalogueItemView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Элемент каталога содержащийся в быстром доступе сразу под выбором категорий
final class CatalogueItemView: UIView {
    // MARK: - Types

    /// Позиция лейбла в данном вью
    enum LabelPosition {
        /// Лейбл позиционирован в самом верху вью
        case top
        /// Лейбл позиционирован в самом низу вью
        case bottom
    }

    // MARK: - Visual Components

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .verdanaBold?.withSize(14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()

    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 40, height: 30)
    }

    // MARK: - Private Properties

    private var labelPosition: LabelPosition = .bottom

    // MARK: - Life Cycle

    init(labelPosition: LabelPosition) {
        super.init(frame: .zero)
        self.labelPosition = labelPosition
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func setTitle(_ title: String?) {
        label.text = title
    }

    func setImage(_ image: UIImage?) {
        imageView.image = image
    }

    // MARK: - Private Methods

    private func configureUI() {
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
        layer.shadowOffset.height = 4
        layer.cornerCurve = .continuous

        addSubviews(label, imageView)
        bringSubviewToFront(label)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: label, imageView)
        [
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
        ].activate()

        switch labelPosition {
        case .top:
            label.topAnchor.constraint(equalTo: topAnchor).activate()
        case .bottom:
            label.bottomAnchor.constraint(equalTo: bottomAnchor).activate()
        }
    }
}
