// ThanksViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// View that shows thanks message after user payed the bill
class ThanksViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var exitButton: UIButton!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.layer.cornerRadius = 12
    }

    // MARK: - Public Methods

    @IBAction func dismissThanksVIew(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
