// LabeledView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Предвставление содержашее два лейбла, заголовок и информацию
final class LabeledView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let labelHeight: CGFloat = 57
    }

    // MARK: - Private Properties

    /// Заголовок
    private var annotationLabel = UILabel()
    /// Информационный лейбл
    private var infoLabel = UILabel()
    private lazy var labels = [annotationLabel, infoLabel]

    // MARK: - Life Cycle

    init() {
        let size = CGSize(width: 0, height: Constants.labelHeight * 2)
        let frame = CGRect(origin: .zero, size: size)
        super.init(frame: frame)
        setUpUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        for (index, label) in labels.enumerated() {
            let origin = CGPoint(x: 0, y: frame.height / CGFloat(labels.count) * CGFloat(index))
            let size = CGSize(width: frame.width, height: frame.height)
            label.frame = CGRect(origin: origin, size: size)
        }
    }

    // MARK: - Public Methods

    /// Устанавливает новый текст в annotationLabel
    func setAnnotationTextTo(_ text: String?) {
        annotationLabel.text = text
    }

    /// Устанавливает новый текст в infoLabel
    func setInfoLabelTextTo(_ text: String?) {
        infoLabel.text = text
    }

    // MARK: - Private Methods

    private func setUpUI() {
        for (index, label) in labels.enumerated() {
            let fontName = "Verdana-Bold\(index == 0 ? "" : "Italic")"
            label.font = UIFont(name: fontName, size: 16)
            label.textColor = index == 0 ? .secondaryText : .systemGray
            label.textAlignment = .center
            label.numberOfLines = 0
        }
        addSubview(annotationLabel)
        addSubview(infoLabel)
    }
}
