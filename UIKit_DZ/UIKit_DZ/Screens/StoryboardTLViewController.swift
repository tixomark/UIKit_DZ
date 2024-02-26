// StoryboardTLViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контроллер со светофором, построенным в сториборде через констрейнты
final class StoryboardTLViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var bodyView: UIView!
    @IBOutlet private var greenView: UIView!
    @IBOutlet private var yellowView: UIView!
    @IBOutlet private var redView: UIView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storyboard"
        UIView.doNotTAMIC(for: bodyView, greenView, yellowView, redView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        greenView.layer.cornerRadius = greenView.bounds.size.width / 2
        yellowView.layer.cornerRadius = yellowView.bounds.size.width / 2
        redView.layer.cornerRadius = redView.bounds.size.width / 2
        bodyView.layer.cornerRadius = bodyView.bounds.size.width / 4
    }
}
