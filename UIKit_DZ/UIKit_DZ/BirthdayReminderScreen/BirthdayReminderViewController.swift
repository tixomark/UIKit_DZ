// BirthdayReminderViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Конроллер обрабатывающий список дней рождений людей
class BirthdayReminderViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let title = "Birthday Reminder"
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: - Private Methods

    private func setUpUI() {
        view.backgroundColor = .systemBackground
        title = Constants.title
        // устанавливаю шрифт для navigationBar
        let navigationTitleFont = UIFont.verdanaBold?.withSize(18) ?? .systemFont(ofSize: 18)
        navigationController?.navigationBar.titleTextAttributes = [.font: navigationTitleFont]

        // добавляю кнопку + в navigationItem
        let addBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton)
        )
        navigationItem.rightBarButtonItem = addBarButtonItem
        
    }

    @objc private func didTapAddButton() {
        print("Add button tapped")
    }
}
