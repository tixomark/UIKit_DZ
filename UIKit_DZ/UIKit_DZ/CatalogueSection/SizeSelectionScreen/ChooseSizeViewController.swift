// ChooseSizeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ChooseSizeViewControllerDelegate: AnyObject {
    func didSelect(_ size: Int)
}

// tixomark
/// Экран выбора размера товара
final class ChooseSizeViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Выберите размер"
        static let sizes = Array(35 ... 39)
        static let sizeUnit = "EU"
    }

    // MARK: - Visual Components

    private let sizeViews: [SizeView] = {
        var views: [SizeView] = []
        for index in Constants.sizes {
            let view = SizeView()
            view.setTitle("\(index) " + Constants.sizeUnit)
            view.tag = index
            views.append(view)
        }
        return views
    }()

    private lazy var navigationBar: UINavigationBar = {
        let cancelButton = UIBarButtonItem(
            image: .xIcon.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        let navigationItem = UINavigationItem(title: Constants.titleText)
        navigationItem.leftBarButtonItem = cancelButton

        let navBar = UINavigationBar()
        navBar.items = [navigationItem]
        navBar.setValue(true, forKey: "hidesShadow")
        navBar.isTranslucent = false

        let navigationTitleFont = UIFont.verdanaBold?.withSize(16) ?? .systemFont(ofSize: 16)
        navBar.titleTextAttributes = [.font: navigationTitleFont]
        return navBar
    }()

    // MARK: - Public Properties

    weak var delegate: ChooseSizeViewControllerDelegate?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        title = Constants.titleText
        view.backgroundColor = .systemBackground
        view.addSubviews(sizeViews)
        view.addSubview(navigationBar)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnView(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: sizeViews)
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: navigationBar)

        for (index, sizeView) in sizeViews.enumerated() {
            if index == 0 {
                sizeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
                    .isActive = true
            } else {
                sizeView.topAnchor.constraint(equalTo: sizeViews[index - 1].bottomAnchor, constant: 10)
                    .isActive = true
            }
            [
                sizeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                sizeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ].activate()
        }

        navigationBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    @objc private func didTapOnView(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: view)

        for sizeView in sizeViews where sizeView.frame.contains(touchLocation) {
            delegate?.didSelect(sizeView.tag)
            dismiss(animated: true)
        }
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

// navigationItem.leftBarButtonItem = cancelButton
// navigationItem.rightBarButtonItem = addButton
//
// navigationBar.items = [navigationItem]
// navigationBar.setValue(true, forKey: "hidesShadow")
// navigationBar.isTranslucent = false
//
// view.addSubviews(navigationBar, headerImageView, changePhotoButton)
