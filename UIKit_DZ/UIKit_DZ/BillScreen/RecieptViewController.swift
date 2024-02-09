// BillViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контроллер отвечающий за отображение чека и оплату счета
final class RecieptViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let goToThanksVCSegueID = "goToThanksSegue"
        
        enum PayAlert {
            static let title = "Вы хотите оплатить чек?"
            static let positiveResponce = "Да"
            static let negativeRecponce = "Отмена"
        }
    }

    // MARK: - IBOutlets

    @IBOutlet private var totalButton: UIButton!

    // MARK: - Public Properties

    var user: User?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        totalButton.layer.cornerRadius = 12
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.goToThanksVCSegueID {
            let detailsVC = segue.destination as? ThanksViewController
            detailsVC?.user = user
        }
    }

    // MARK: - Private Methods

    /// Спрашивает нужно ли оплатить счет
    private func showPayAlert() {
        let alert = UIAlertController(title: Constants.PayAlert.title, message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: Constants.PayAlert.positiveResponce, style: .default) { _ in
            self.performSegue(withIdentifier: Constants.goToThanksVCSegueID, sender: self)
        }
        let cancelAction = UIAlertAction(title: Constants.PayAlert.negativeRecponce, style: .default)

        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        alert.preferredAction = yesAction
        present(alert, animated: true)
    }

    // MARK: - IBAction

    @IBAction private func totalButtonTapped(_ sender: UIButton) {
        showPayAlert()
    }
}
