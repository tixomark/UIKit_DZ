// NotificationsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран содержащий историю уведомлений пользователя
final class NotificationsViewController: UIViewController {
    // MARK: - Types

    /// Типы секций таблиыи нотификаций
    private enum NotificationSectionType {
        /// Секция запросов на подписку
        case requests
        /// Секция нотификаций за сегодня
        case tooday
        /// Секция нотификаций за неделю  исключая сегодня
        case thisWeek
    }

    // MARK: - Constants

    private enum Constants {
        static let notificationText = "Уведомления"
        static let requestsText = "Запросы на подписку"
        static let todayText = "Сегодня"
        static let thisWeekText = "На этой неделе"
    }

    // MARK: - Visual Components

    private lazy var notificationTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(NotionCell.self, forCellReuseIdentifier: NotionCell.description())
        tableView.register(SubscriptionCell.self, forCellReuseIdentifier: SubscriptionCell.description())
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.description())
        return tableView
    }()

    // MARK: - Private Properties

    private var tableStructure: [NotificationSectionType] = [.requests, .tooday, .thisWeek]
    private var dataProvider: DataProvider!

    // MARK: - Life Cycle

    convenience init(dataProvider: DataProvider) {
        self.init()
        self.dataProvider = dataProvider
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = Constants.notificationText
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(notificationTableView)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: notificationTableView)
        [
            notificationTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notificationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notificationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notificationTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].activate()
    }
}

extension NotificationsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableStructure.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableStructure[section] {
        case .requests:
            1
        case .tooday:
            dataProvider.notifications[0].count
        case .thisWeek:
            dataProvider.notifications[1].count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableStructure[indexPath.section] {
        case .requests:
            let cell = UITableViewCell()
            cell.textLabel?.font = .verdana?.withSize(14)
            cell.textLabel?.text = Constants.requestsText
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = .accent
            return cell
        case .tooday, .thisWeek:
            let notification = dataProvider.notifications[indexPath.section - 1][indexPath.row]
            switch notification {
            case is Notion:
                guard let data = notification as? Notion,
                      let cell = tableView.dequeueReusableCell(
                          withIdentifier: NotionCell.description(),
                          for: indexPath
                      ) as? NotionCell
                else { return UITableViewCell() }

                cell.configure(with: data)
                return cell
            case is Subscription:
                guard let data = notification as? Subscription,
                      let cell = tableView.dequeueReusableCell(
                          withIdentifier: SubscriptionCell.description(),
                          for: indexPath
                      ) as? SubscriptionCell
                else { return UITableViewCell() }

                cell.configure(with: data)
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
}

extension NotificationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if case .requests = tableStructure[indexPath.section] {
            17
        } else {
            UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = tableView
            .dequeueReusableHeaderFooterView(withIdentifier: HeaderView.description()) as? HeaderView
        switch tableStructure[section] {
        case .requests:
            return nil
        case .tooday:
            headerLabel?.setTitle(Constants.todayText)
        case .thisWeek:
            headerLabel?.setTitle(Constants.thisWeekText)
        }
        return headerLabel
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if case .requests = tableStructure[section] {
            0
        } else {
            UITableView.automaticDimension
        }
    }
}
