// StackViewTLViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контроллер со светофором, построенным на StackView в коде
final class StackViewTLViewController: UIViewController {
    // MARK: - Visual Components

    private let bodyView = TrafficLightView(.trafficBlack, cornerRoundnessDegree: .quater)
    private let redView = TrafficLightView(.trafficRed, cornerRoundnessDegree: .half)
    private let yellowView = TrafficLightView(.trafficYellow, cornerRoundnessDegree: .half)
    private let greenView = TrafficLightView(.trafficGreen, cornerRoundnessDegree: .half)

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [redView, yellowView, greenView])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()

    private var safeArea: UILayoutGuide {
        view.safeAreaLayoutGuide
    }

    // MARK: - Constants
    // MARK: - Types
    // MARK: - Public Methods
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        title = "StackView"
        view.addSubviews(bodyView, stackView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: bodyView, stackView)
        configureBodyViewLayout()
        configureStackViewLayout()
    }

    private func configureBodyViewLayout() {
        [
            bodyView.topAnchor.constraint(equalTo: redView.topAnchor, constant: -15),
            bodyView.leadingAnchor.constraint(equalTo: redView.leadingAnchor, constant: -25),
            bodyView.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 25),
            bodyView.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 15)
        ].activate()
    }

    private func configureStackViewLayout() {
        [
            stackView.topAnchor.constraint(greaterThanOrEqualTo: safeArea.topAnchor, constant: 45),
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 186).priority(700),
            stackView.widthAnchor.constraint(equalToConstant: 110).priority(750),
            stackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),

            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -45),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -186).priority(700),

            stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: (110 * 3 + 16) / 110),
//            stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 3)
        ].activate()
    }
    
    private func setupUI() {
        let storyBoardButton = makeButton(text: Constants.storyButtonLabel, tag: 0)
        let stackViewButton = makeButton(text: Constants.stackButtonLabel, tag: 1)
        let anchorButton = makeButton(text: Constants.anchorButtonLabel, tag: 2)

        NSLayoutConstraint.activate([
            storyBoardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 280),
            stackViewButton.topAnchor.constraint(equalTo: storyBoardButton.bottomAnchor, constant: 30),
            anchorButton.topAnchor.constraint(equalTo: stackViewButton.bottomAnchor, constant: 30),
        ])
       }

    private func makeButton(text: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.backgroundColor = .magenta
        button.layer.cornerRadius = 10
        button.tag = tag
        button.addTarget(self, action: #selector(menuListButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return button
    }
    
    @objc private func menuListButtonTapped(_ sender: UIButton) {
        var controllerToPresent = UIViewController()
        switch sender.tag {
        case 0:
            guard let nextViewController = UIStoryboard(name: "Main", bundle: .main)
                .instantiateViewController(withIdentifier: "StoryBoardViewController") as? StoryBoardViewController
            else { return }
            controllerToPresent = nextViewController
        case 1:
            controllerToPresent = StackViewController()
        case 2:
            controllerToPresent = AnchorViewController()
        default:
            break
        }
        navigationController?.pushViewController(controllerToPresent, animated: true)
    }
}
