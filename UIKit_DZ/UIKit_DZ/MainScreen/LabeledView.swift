// LabeledView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// View that contains two labels for using in MainViewController
class LabeledView: UIView {
    // MARK: - Private Properties

    private let labelHeight: CGFloat = 57
    private lazy var labels = [annotationLabel, infoLabel]

    private var annotationLabel = UILabel()
    private var infoLabel = UILabel()

    // MARK: - Life Cycle

    init() {
        let frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: 0,
                height: labelHeight * 2
            )
        )
        super.init(frame: frame)
        setUpUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        for (index, label) in labels.enumerated() {
            label.frame = CGRect(
                origin: CGPoint(
                    x: 0,
                    y: frame.height / CGFloat(labels.count) * CGFloat(index)
                ),
                size: CGSize(
                    width: frame.width,
                    height: frame.height
                )
            )
        }
    }

    // MARK: - Public Methods

    func setInfoLabelTextTo(_ text: String?) {
        infoLabel.text = text
    }

    func setAnnotationTextTo(_ text: String?) {
        annotationLabel.text = text
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
