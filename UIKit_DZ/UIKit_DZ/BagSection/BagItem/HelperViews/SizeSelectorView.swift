// SizeSelectorView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol SizeSelectorViewDelegate: AnyObject {
    /// Метод делегата информирующий об изменении выбора размера
    func didSelect(_ size: Int)
}

/// Набор нескольких SizeLabel с которыми можно взаимодействовать тапами
final class SizeSelectorView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let sizes = Array(35 ... 39)
    }

    // MARK: - Visual Components

    private let sizeLabels: [SizeLabel] = {
        var labels: [SizeLabel] = []
        for index in Constants.sizes {
            let label = SizeLabel()
            label.text = "\(index)"
            label.tag = index
            labels.append(label)
        }
        return labels
    }()

    // MARK: - Public Properties

    weak var delegate: SizeSelectorViewDelegate?

    // MARK: - Private Properties

    private var selectedLabel: SizeLabel?

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

    // MARK: - Public Methods

    func setSelectedSize(_ size: Int) {
        selectedLabel = sizeLabels[Constants.sizes.firstIndex(of: size) ?? 0]
        selectedLabel?.setState(to: .highlited)
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubviews(sizeLabels)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnView(_:)))
        addGestureRecognizer(tapGesture)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: sizeLabels)

        for (index, label) in sizeLabels.enumerated() {
            if index % 4 == 0 {
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6).activate()
                if index == 0 {
                    label.topAnchor.constraint(equalTo: topAnchor).activate()
                } else {
                    label.topAnchor.constraint(equalTo: sizeLabels[index - 4].bottomAnchor, constant: 4).activate()
                }
            } else {
                label.leadingAnchor.constraint(equalTo: sizeLabels[index - 1].trailingAnchor, constant: 4).activate()
            }

            if index % 4 == 3 {
                label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6).activate()
            }
        }
        sizeLabels.last?.bottomAnchor.constraint(equalTo: bottomAnchor).activate()
    }

    @objc private func didTapOnView(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: self)
        for label in sizeLabels where label.frame.contains(touchLocation) {
            selectedLabel?.setState(to: .normal)
            selectedLabel = label
            selectedLabel?.setState(to: .highlited)
            delegate?.didSelect(label.tag)
        }
    }
}
