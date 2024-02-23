// UserGalleryCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Галерея изображений из постов текущего авторизованного пользователя
final class UserGalleryCell: UITableViewCell {
    private enum Constants {
        static let numberOfItemsInRow = 3
        static let spacing: CGFloat = 1.5
        static let itemWidth = (UIScreen.main.bounds.width - spacing * CGFloat(numberOfItemsInRow - 1)) /
            CGFloat(numberOfItemsInRow)
    }

    // MARK: - Visual Components

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.spacing
        layout.minimumInteritemSpacing = Constants.spacing
        layout.itemSize = CGSize(width: Constants.itemWidth, height: Constants.itemWidth)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.isScrollEnabled = false
        collection.register(
            OneImageCollectionViewCell.self,
            forCellWithReuseIdentifier: OneImageCollectionViewCell.description()
        )
        return collection
    }()

    // MARK: - Private Properties

    private var galleryImageNames: [AssetImageName] = []

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

    func configure(with imageNames: [AssetImageName]) {
        galleryImageNames = imageNames
        var numberOfRows = imageNames.count / Constants.numberOfItemsInRow
        if imageNames.count % Constants.numberOfItemsInRow != 0 {
            numberOfRows += 1
        }
        let collectionViewHeght = (Constants.itemWidth + Constants.spacing) * CGFloat(numberOfRows)
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeght.rounded()).activate()
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubviews(collectionView)
        contentView.backgroundColor = .red
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: collectionView)
        [
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ].activate()
    }
}

extension UserGalleryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        galleryImageNames.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OneImageCollectionViewCell.description(),
            for: indexPath
        ) as? OneImageCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        let image = UIImage(galleryImageNames[indexPath.item])
        cell.configure(with: image)
        return cell
    }
}
