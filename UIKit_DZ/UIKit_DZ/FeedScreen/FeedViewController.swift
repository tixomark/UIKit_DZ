// FeedViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран ленты RMLink
final class FeedViewController: UIViewController {
    // MARK: - Types

    /// Тип секции в ленте
    enum FeedSectionType {
        /// Секция истории
        case stories
        /// Секция постов с указанием количества
        case feedItems(_ amount: Int)
        /// Секция рекомендаций
        case recomendations
    }

    // MARK: - Constants

    private enum Constants {
        static let appNameText = "RMLink"
    }

    // MARK: - Visual Components

    private lazy var feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInset.top = 7
        tableView.register(StoriesCell.self, forCellReuseIdentifier: StoriesCell.description())
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.description())
        tableView.register(RecomendationsCell.self, forCellReuseIdentifier: RecomendationsCell.description())
        return tableView
    }()

    // MARK: - Private Properties

    private var feedStructure: [FeedSectionType] = [
        .stories, .feedItems(1), .recomendations, .feedItems(5)
    ]
    private var dataProvider: DataProvider!

    // MARK: - Life Cycle

    convenience init(dataProvider: DataProvider) {
        self.init()
        self.dataProvider = dataProvider
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(feedTableView)
        configureNavigationBar()
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: view.subviews)
        [
            feedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].activate()
    }

    private func configureNavigationBar() {
        let label = UILabel()
        label.text = Constants.appNameText
        label.font = .dancingScriptBold?.withSize(22)
        label.textColor = .accent
        let leftItem = UIBarButtonItem(customView: label)
        navigationItem.leftBarButtonItem = leftItem

        let imageView = UIImageView(image: .signalMessageIcon.withTintColor(.accent))
        let rightItem = UIBarButtonItem(customView: imageView)
        navigationItem.rightBarButtonItem = rightItem

        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
}

extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        feedStructure.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch feedStructure[section] {
        case .stories, .recomendations:
            1
        case let .feedItems(amount):
            amount
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch feedStructure[indexPath.section] {
        case .stories:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: StoriesCell.description(),
                for: indexPath
            ) as? StoriesCell
            else { return UITableViewCell() }

            cell.configure(with: dataProvider.stories)
            return cell
        case .feedItems:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PostCell.description(),
                for: indexPath
            ) as? PostCell
            else { return UITableViewCell() }

            let post = dataProvider.post(
                forRow: indexPath.row,
                sectionType: feedStructure[indexPath.section]
            )
            cell.configure(with: post)
            return cell
        case .recomendations:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecomendationsCell.description(),
                for: indexPath
            ) as? RecomendationsCell
            else { return UITableViewCell() }

            cell.configure(with: dataProvider.recomendations)
            return cell
        }
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
