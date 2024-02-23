// UserProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля пользователя
final class UserProfileViewController: UIViewController {
    // MARK: - Types

    /// Тип секций в таблице
    enum UserProfileSection {
        /// Секция истории
        case profile
        /// Секция постов с указанием количества
        case stories
        /// Секция рекомендаций
        case postImages
    }

    // MARK: - Visual Components

    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(UserProfileCell.self, forCellReuseIdentifier: UserProfileCell.description())
        tableView.register(UserStoriesCell.self, forCellReuseIdentifier: UserStoriesCell.description())
        tableView.register(UserGalleryCell.self, forCellReuseIdentifier: UserGalleryCell.description())
        return tableView
    }()

    // MARK: - Private Properties

    private var profileSections: [UserProfileSection] = [.profile, .stories, .postImages]
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
        view.addSubview(profileTableView)
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        let leftBarView = UserProfileNavigationBarLeftView()
        leftBarView.configure(with: dataProvider.currentUser.nickname)
        let rightBarView = UserProfileNavigationBarRightView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarView)
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: profileTableView)
        [
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].activate()
    }
}

extension UserProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        profileSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch profileSections[indexPath.section] {
        case .profile:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: UserProfileCell.description(),
                for: indexPath
            ) as? UserProfileCell
            else { return UITableViewCell() }

            cell.configure(with: dataProvider.currentUser)
            cell.tapLinkButtonHandler = { [unowned self] in
                let webController = WebViewController()
                webController.configure(with: dataProvider.currentUser.link)
                webController.modalPresentationStyle = .fullScreen
                present(webController, animated: true)
            }
            return cell

        case .stories:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: UserStoriesCell.description(),
                for: indexPath
            ) as? UserStoriesCell
            else { return UITableViewCell() }

            cell.configure(with: dataProvider.currentUserStories)
            cell.tapStoryHandler = { [unowned self] index in
                let storyController = StoryViewController()
                storyController.configure(with: dataProvider.currentUserStories[index])
                storyController.modalPresentationStyle = .fullScreen
                present(storyController, animated: true)
            }

            return cell

        case .postImages:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: UserGalleryCell.description(),
                for: indexPath
            ) as? UserGalleryCell
            else { return UITableViewCell() }

            cell.configure(with: dataProvider.currentUserGallery)
            return cell
        }
    }
}

extension UserProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
