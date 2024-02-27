// ConstraintTLViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контроллер со светофором, построенным на констрейнтах в коде
final class ConstraintTLViewController: UIViewController {
    // MARK: - Visual Components

    private let bodyView = TrafficLightView(.trafficBlack, cornerRoundnessDegree: .quater)
    private let redView = TrafficLightView(.trafficRed, cornerRoundnessDegree: .half)
    private let yellowView = TrafficLightView(.trafficYellow, cornerRoundnessDegree: .half)
    private let greenView = TrafficLightView(.trafficGreen, cornerRoundnessDegree: .half)

    // MARK: - Private Properties

    private var safeArea: UILayoutGuide {
        view.safeAreaLayoutGuide
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        title = "Constraint"
        view.addSubviews(bodyView, redView, yellowView, greenView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: bodyView, redView, yellowView, greenView)
        configureBodyViewLayout()
        configureRedViewLayout()
        configureYellowViewLayout()
        configureGreenViewLayout()
    }

    private func configureBodyViewLayout() {
        [
            .init(bodyView, attr: .top, relatedBy: .equal, to: redView, attr: .top, constant: -15),
            .init(bodyView, attr: .leading, relatedBy: .equal, to: redView, attr: .leading, constant: -25),
            .init(bodyView, attr: .trailing, relatedBy: .equal, to: redView, attr: .trailing, constant: 25),
            .init(bodyView, attr: .bottom, relatedBy: .equal, to: greenView, attr: .bottom, constant: 15)
        ].activate()
    }

    private func configureRedViewLayout() {
        [
            .init(redView, attr: .top, relatedBy: .greaterThanOrEqual, to: safeArea, attr: .top, constant: 45),
            .init(redView, attr: .top, relatedBy: .equal, to: safeArea, attr: .top, constant: 186).priority(700),
            .init(redView, attr: .height, relatedBy: .equal, to: yellowView, attr: .height),
            .init(redView, attr: .width, relatedBy: .equal, to: redView, attr: .height),
            .init(redView, attr: .bottom, relatedBy: .equal, to: yellowView, attr: .top, constant: -8),
            .init(redView, attr: .centerX, relatedBy: .equal, to: safeArea, attr: .centerX)
        ].activate()
    }

    private func configureYellowViewLayout() {
        [
            .init(yellowView, attr: .width, relatedBy: .equal, constant: 110).priority(750),
            .init(yellowView, attr: .height, relatedBy: .equal, to: yellowView, attr: .width),
            .init(yellowView, attr: .centerX, relatedBy: .equal, to: safeArea, attr: .centerX),
            .init(yellowView, attr: .centerY, relatedBy: .equal, to: safeArea, attr: .centerY)
        ].activate()
    }

    private func configureGreenViewLayout() {
        [
            .init(greenView, attr: .top, relatedBy: .equal, to: yellowView, attr: .bottom, constant: 8),
            .init(greenView, attr: .height, relatedBy: .equal, to: yellowView, attr: .height),
            .init(greenView, attr: .width, relatedBy: .equal, to: greenView, attr: .height),
            .init(greenView, attr: .centerX, relatedBy: .equal, to: safeArea, attr: .centerX),
            .init(greenView, attr: .bottom, relatedBy: .lessThanOrEqual, to: safeArea, attr: .bottom, constant: -45),
            .init(greenView, attr: .bottom, relatedBy: .equal, to: safeArea, attr: .bottom, constant: -186)
                .priority(700)
        ].activate()
    }
}
