// VFL_TLViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контроллер со светофором, построенным через VFL
final class VFLTLViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let padding: CGFloat = 8
        static let verticalOffsetToContainer: CGFloat = 44
        static let bodyToLightVerticalSpacing: CGFloat = 15
        static let bodyToLightHorizontalSpacing: CGFloat = 25
    }

    // MARK: - Visual Components

    private let bodyView = TrafficLightView(.trafficBlack, cornerRoundnessDegree: .quater)
    private let redView = TrafficLightView(.trafficRed, cornerRoundnessDegree: .half)
    private let yellowView = TrafficLightView(.trafficYellow, cornerRoundnessDegree: .half)
    private let greenView = TrafficLightView(.trafficGreen, cornerRoundnessDegree: .half)

    // MARK: - Private Properties

    private var allConstraints: [NSLayoutConstraint] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        title = "VFL"
        view.addSubviews(bodyView, redView, yellowView, greenView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: bodyView, redView, yellowView, greenView)
    }

    private func updateLayout() {
        let insets = view.safeAreaInsets
        let visibleViewHeight = view.bounds.height - insets.top - insets.bottom
        let freeHeight = visibleViewHeight - Constants.padding * 2 - Constants.verticalOffsetToContainer * 2
        let approximateLightSide = freeHeight / 3
        let lightSide = min(approximateLightSide, 110)
        let bodyWidth = lightSide + Constants.bodyToLightHorizontalSpacing * 2
        let bodyHeight = lightSide * 3 + Constants.bodyToLightVerticalSpacing * 2 + Constants.padding * 2

        let viewsMap: [String: Any] = [
            "view": view ?? UIView(),
            "body": bodyView,
            "red": redView,
            "yellow": yellowView,
            "green": greenView
        ]

        let metricsMap: [String: CGFloat] = [
            "lightSide": lightSide,
            "bodyW": bodyWidth,
            "bodyH": bodyHeight
        ]

        NSLayoutConstraint.deactivate(allConstraints)
        allConstraints.removeAll()

        allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: "H:[view]-(<=0)-[yellow(lightSide)]-(<=0)-[body(bodyW)]",
            options: .alignAllCenterY,
            metrics: metricsMap,
            views: viewsMap
        )
        allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: "V:[view]-(<=0)-[yellow(lightSide)]-(<=0)-[body(bodyH)]",
            options: .alignAllCenterX,
            metrics: metricsMap,
            views: viewsMap
        )
        allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: "H:[red(==yellow)]",
            metrics: nil,
            views: viewsMap
        )
        allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: "H:[green(==yellow)]",
            metrics: nil,
            views: viewsMap
        )
        allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: "V:[red(==yellow)]-[yellow]-[green(==yellow)]",
            options: .alignAllCenterX,
            metrics: nil,
            views: viewsMap
        )

        allConstraints.activate()
    }
}
