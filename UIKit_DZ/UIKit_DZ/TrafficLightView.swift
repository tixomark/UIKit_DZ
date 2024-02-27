// TrafficLightView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Вью с автоматически изменяющимися радиусами углов
final class TrafficLightView: UIView {
    // MARK: - Types

    /// На какую часть ширины вью закруглять ее углы
    enum RelativeCornerRoundnes: Int {
        /// Закругление размером в половину ширины
        case half = 2
        /// Закругление размером в треть ширины
        case third
        /// Закругление размером в четверть ширины
        case quater
    }

    // MARK: - Private Properties

    private var cornerRoundnessDegree: RelativeCornerRoundnes

    // MARK: - Initializers

    init(_ color: UIColor, cornerRoundnessDegree: RelativeCornerRoundnes) {
        self.cornerRoundnessDegree = cornerRoundnessDegree
        super.init(frame: .zero)
        backgroundColor = color
    }

    required init?(coder: NSCoder) {
        cornerRoundnessDegree = .half
        super.init(coder: coder)
    }

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / CGFloat(cornerRoundnessDegree.rawValue)
    }
}
