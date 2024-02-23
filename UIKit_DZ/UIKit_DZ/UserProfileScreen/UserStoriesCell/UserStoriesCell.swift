// UserStoriesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерактивная ячейка с возможность просмотреть истории авторизированного пользователя
final class UserStoriesCell: UITableViewCell {
    // MARK: - Visual Components

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset.left = 18
        layout.sectionInset.right = 18
        layout.itemSize = CGSize(width: 54, height: 70)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.register(
            UserStoryCollectionViewCell.self,
            forCellWithReuseIdentifier: UserStoryCollectionViewCell.description()
        )
        return collection
    }()

    var tapStoryHandler: ((Int) -> (Void))?

    // MARK: - Private Properties

    private var stories: [UserStory] = []

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Private Methods

    func configure(with stories: [UserStory]) {
        self.stories = stories
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubviews(collectionView)
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: collectionView)
        [
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            collectionView.heightAnchor.constraint(equalToConstant: 90)
        ].activate()
    }
}

extension UserStoriesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stories.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UserStoryCollectionViewCell.description(),
            for: indexPath
        ) as? UserStoryCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        cell.configure(with: stories[indexPath.item])
        return cell
    }
}

extension UserStoriesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapStoryHandler?(indexPath.item)
    }
}
