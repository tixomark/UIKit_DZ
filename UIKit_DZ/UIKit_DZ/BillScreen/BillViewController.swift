// BillViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// View controller that manages billing screen
class BillViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var totalButton: UIButton!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        totalButton.layer.cornerRadius = 12
    }

    // MARK: - Public Methods

    @IBAction func totalButtonTapped(_ sender: UIButton) {
        showPayAlert()
    }

    // MARK: - Private Methods

    private func showPayAlert() {
        let alert = UIAlertController(title: "Вы хотите оплатить чек?", message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .default) { _ in
            //            self.performSegue(withIdentifier: "goToRecieptSegue", sender: self)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)

        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        alert.preferredAction = yesAction

        present(alert, animated: true)
    }
}
