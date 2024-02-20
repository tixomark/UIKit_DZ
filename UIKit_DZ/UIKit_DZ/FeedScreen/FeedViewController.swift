// FeedViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран ленты RMLink
final class FeedViewController: UIViewController {
    // MARK: - Types

    private enum FeedSectionType {
        case stories
        case feedItems(_ amount: Int)
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
        tableView.register(StoriesCell.self, forCellReuseIdentifier: StoriesCell.description())
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.description())
        tableView.register(RecomendationsCell.self, forCellReuseIdentifier: RecomendationsCell.description())
        return tableView
    }()

    private let navigationBar = UINavigationBar()

    // MARK: - Private Properties

    private var feedStructure: [FeedSectionType] = [
        .stories, .feedItems(1), .recomendations, .feedItems(5)
    ]
    private var dataStore = DataStore()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        view.addSubview(feedTableView)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: view.subviews)
        [
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            feedTableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
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

        let imageView = UIImageView(image: .signalMessageIcon.withTintColor(.accent))
        let rightItem = UIBarButtonItem(customView: imageView)

        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.rightBarButtonItem = rightItem

        navigationBar.items = [navigationItem]
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .systemBackground
        navigationBar.setValue(true, forKey: "hidesShadow")
        view.addSubview(navigationBar)
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

            cell.configure(with: dataStore.stories)
            return cell
        case .feedItems:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PostCell.description(),
                for: indexPath
            ) as? PostCell
            else { return UITableViewCell() }

            cell.configure(with: dataStore.posts[indexPath.row])
            return cell
        case .recomendations:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecomendationsCell.description(),
                for: indexPath
            ) as? RecomendationsCell
            else { return UITableViewCell() }

            cell.configure(with: dataStore.recomendations)
            return cell
        }
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch feedStructure[indexPath.section] {
//        case .stories, .recomendations:
//            75
//        case let .feedItems(amount):
//            400
//        }
        UITableView.automaticDimension
    }
}
