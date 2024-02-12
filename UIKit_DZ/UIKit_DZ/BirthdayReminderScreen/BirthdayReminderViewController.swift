// BirthdayReminderViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Конроллер обрабатывающий список дней рождений людей
final class BirthdayReminderViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let title = "Birthday Reminder"
    }

    // MARK: - Private Properties

    /// Массив хранящий данные о людях и их днях рождениях
    private var people = [
        PersonData(image: UIImage(.helena), name: "Helena Link", birthday: "12.02.2016".toDate()),
        PersonData(image: UIImage(.verona), name: "Verona Tusk", birthday: "20.03.2017".toDate()),
        PersonData(image: UIImage(.alex), name: "Alex Smith", birthday: "21.04.2014".toDate()),
        PersonData(image: UIImage(.tom), name: "Tom Johnson", birthday: "05.06.2012".toDate())
    ]

    /// Массив ячеек таблицы дней рождений
    private var birthdayInfoViews: [BirthdayInfoView] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        reloadTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTableElementsFrames()
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

        for _ in people.indices {
            let infoView = BirthdayInfoView()
            infoView.isHidden = true
            view.addSubview(infoView)
            birthdayInfoViews.append(infoView)
        }
    }

    /// Расставляет ячейки с днями рождениями по порядку друг за другом
    private func setUpTableElementsFrames() {
        for (index, infoView) in birthdayInfoViews.enumerated() {
            var origin = CGPoint(x: 19, y: 100)
            if index != 0 {
                origin.y += (75 + 20) * CGFloat(index)
            }
            var size = infoView.frame.size
            size.width = view.bounds.width - 19 * 2
            infoView.frame = CGRect(origin: origin, size: size)

            if infoView.isHidden {
                infoView.isHidden = false
            }
        }
    }

    /// Заполняет таблицу данными о людях
    private func reloadTable() {
        let calculator = BirthdayCalculator()
        let df = DateFormatter()
        df.dateFormat = "dd.MM"

        for (index, infoView) in birthdayInfoViews.enumerated() {
            let person = people[index]
            let birthday = df.string(from: person.birthday)
            let age = calculator.yearsSince(person.birthday)
            let daysUntilBitrhday = calculator.daysUntil(person.birthday)

            var ageString = birthday + " - turns \(age + 1)"
            if daysUntilBitrhday == 0 {
                ageString += "!"
            }

            infoView.setUpWith(
                image: person.image,
                name: person.name,
                age: ageString,
                countdown: daysUntilBitrhday
            )
        }
    }

    @objc private func didTapAddButton() {
        let addUserVC = AddUserViewController()
        addUserVC.delegate = self
        addUserVC.modalPresentationStyle = .pageSheet
        present(addUserVC, animated: true)
    }
}

extension BirthdayReminderViewController: AddUserViewControllerDelegate {
    /// Получает созданного на экране создания человека. Добавляет кго в массив людей
    func didSuccessfulyAddPerson(_ person: PersonData) {
        people.append(person)

        let infoView = BirthdayInfoView()
        view.addSubview(infoView)
        birthdayInfoViews.append(infoView)

        setUpTableElementsFrames()
        reloadTable()
    }
}
