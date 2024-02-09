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

    private func showBillAlert() {
        let alert = UIAlertController(title: "Выставить счет", message: nil, preferredStyle: .alert)
        let billAction = UIAlertAction(title: "Чек", style: .default) { _ in
            self.performSegue(withIdentifier: "goToRecieptSegue", sender: self)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)

        alert.addAction(cancelAction)
        alert.addAction(billAction)
        alert.preferredAction = billAction

        present(alert, animated: true)
    }

    // MARK: - Public Methods

    @IBAction func switchDidToggle(_ sender: UISwitch) {}

    @IBAction func billButtonTapped(_ sender: UIButton) {
        showBillAlert()
    }
}
