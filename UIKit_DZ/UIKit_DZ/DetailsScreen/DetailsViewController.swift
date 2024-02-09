// DetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Second creen with adjustable parameters
final class DetailsViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var billButton: UIButton!
    @IBOutlet var switches: [UISwitch]!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        billButton.layer.cornerRadius = 12
    }

    // MARK: - Public Methods
    @IBAction func switchDidToggle(_ sender: UISwitch) {}
    
    @IBAction func billButtonTapped(_ sender: UIButton) {}
}
