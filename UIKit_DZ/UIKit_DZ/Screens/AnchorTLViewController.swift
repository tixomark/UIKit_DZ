// AnchorTLViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контроллер со светофором, построенным на якорях в коде
final class AnchorTLViewController: UIViewController {
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
        title = "Anchor"
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
            bodyView.topAnchor.constraint(equalTo: redView.topAnchor, constant: -15),
            bodyView.leadingAnchor.constraint(equalTo: redView.leadingAnchor, constant: -25),
            bodyView.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 25),
            bodyView.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 15)
        ].activate()
    }

    private func configureRedViewLayout() {
        [
            redView.topAnchor.constraint(greaterThanOrEqualTo: safeArea.topAnchor, constant: 45),
            redView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 186).priority(700),
            redView.heightAnchor.constraint(equalTo: yellowView.heightAnchor),
            redView.widthAnchor.constraint(equalTo: redView.heightAnchor),
            redView.bottomAnchor.constraint(equalTo: yellowView.topAnchor, constant: -8),
            redView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ].activate()
    }

    private func configureYellowViewLayout() {
        [
            yellowView.widthAnchor.constraint(equalToConstant: 110).priority(750),
            yellowView.heightAnchor.constraint(equalTo: yellowView.widthAnchor),
            yellowView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            yellowView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ].activate()
    }

    private func configureGreenViewLayout() {
        [
            greenView.topAnchor.constraint(equalTo: yellowView.bottomAnchor, constant: 8),
            greenView.heightAnchor.constraint(equalTo: yellowView.heightAnchor),
            greenView.widthAnchor.constraint(equalTo: greenView.heightAnchor),
            greenView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            greenView.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -45),
            greenView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -186).priority(700)
        ].activate()
    }
}
