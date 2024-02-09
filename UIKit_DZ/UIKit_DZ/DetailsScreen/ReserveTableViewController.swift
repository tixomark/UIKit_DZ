// ReserveTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран бронирования стола
final class ReserveTableViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let goToBillVCSegueID = "goToRecieptSegue"
    }

    // MARK: - IBOutlets

    @IBOutlet private var billButton: UIButton!
    @IBOutlet private var switches: [UISwitch]!

    // MARK: - Public Properties

    var user: User?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.goToBillVCSegueID {
            let detailsVC = segue.destination as? RecieptViewController
            detailsVC?.user = user
        }
    }

    // MARK: - Private Methods

    private func setUpUI() {
        billButton.layer.cornerRadius = 12
    }

    /// Показывает алерт с сообщением о выставлении счета
    private func showBillAlert() {
        let alert = UIAlertController(title: "Выставить счет", message: nil, preferredStyle: .alert)
        let billAction = UIAlertAction(title: "Чек", style: .default) { _ in
            self.performSegue(withIdentifier: Constants.goToBillVCSegueID, sender: self)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)

        alert.addAction(cancelAction)
        alert.addAction(billAction)
        alert.preferredAction = billAction

        present(alert, animated: true)
    }

    // MARK: - IBAction

    @IBAction private func billButtonTapped(_ sender: UIButton) {
        showBillAlert()
    }
}
