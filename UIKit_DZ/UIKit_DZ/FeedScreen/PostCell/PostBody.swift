// PostBody.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Основная часть ячейки поста c изображениями, функциональными элементами и счетчиком лайков
final class PostBody: UIView {
    // MARK: - Constants

    private enum Constants {
        static let amountOfLikesText = "Нравится: "
    }

    // MARK: - Visual Components

    private let likeImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = .likeIcon.withTintColor(.accent)
        return view
    }()

    private let commentImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = .messageIcon.withTintColor(.accent)
        return view
    }()

    private let shareImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = .shareIcon.withTintColor(.accent)
        return view
    }()

    private let imageScrollPageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.hidesForSinglePage = true
        control.isUserInteractionEnabled = false
        control.pageIndicatorTintColor = .opaqueSeparator
        control.currentPageIndicatorTintColor = .accent
        return control
    }()

    private let bookMarkImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = .bookmarkIcon.withTintColor(.accent)
        return view
    }()

    private let numberOfLikesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .accent
        label.font = .verdanaBold?.withSize(10)
        label.textAlignment = .left
        label.text = Constants.amountOfLikesText
        return label
    }()

    private lazy var imageScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.bounces = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.delegate = self
        return scroll
    }()

    // MARK: - Private Properties

    private var imageScrollImageViews: [UIImageView] = []

    // MARK: - Life Cycle

    init() {
        super.init(frame: .zero)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func configure(images: [AssetImageName], numberOfLikes amount: Int = 0) {
        numberOfLikesLabel.text = Constants.amountOfLikesText + "\(amount)"

        guard images.count != imageScrollImageViews.count else { return }
        configureImageScroll(with: images)
        configureImageScrollLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .systemBackground
        addSubviews(imageScrollView, likeImageView, commentImageView)
        addSubviews(shareImageView, imageScrollPageControl, bookMarkImageView, numberOfLikesLabel)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: subviews)
        [
            imageScrollView.topAnchor.constraint(equalTo: topAnchor),
            imageScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageScrollView.widthAnchor.constraint(equalTo: widthAnchor),
            imageScrollView.heightAnchor.constraint(equalTo: imageScrollView.widthAnchor, multiplier: 0.64),

            likeImageView.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 8),
            likeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),

            commentImageView.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 8),
            commentImageView.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 8),

            shareImageView.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 8),
            shareImageView.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 8),

            imageScrollPageControl.centerYAnchor.constraint(equalTo: shareImageView.centerYAnchor),
            imageScrollPageControl.centerXAnchor.constraint(equalTo: centerXAnchor),

            bookMarkImageView.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 8),
            bookMarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            numberOfLikesLabel.topAnchor.constraint(equalTo: likeImageView.bottomAnchor, constant: 10),
            numberOfLikesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            numberOfLikesLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].activate()
    }

    private func configureImageScroll(with images: [AssetImageName]) {
        imageScrollImageViews.forEach { $0.removeFromSuperview() }
        imageScrollImageViews = []

        for name in images {
            let image = UIImage(name)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageScrollImageViews.append(imageView)
        }
        imageScrollView.addSubviews(imageScrollImageViews)
        imageScrollView.isPagingEnabled = !images.isEmpty

        imageScrollPageControl.numberOfPages = imageScrollImageViews.count
    }

    private func configureImageScrollLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: imageScrollImageViews)

        for (index, imageView) in imageScrollImageViews.enumerated() {
            switch index {
            case 0:
                imageView.leadingAnchor.constraint(equalTo: imageScrollView.leadingAnchor).activate()
            case imageScrollImageViews.count - 1:
                imageView.trailingAnchor.constraint(equalTo: imageScrollView.trailingAnchor).activate()
                fallthrough
            default:
                let previousimageView = imageScrollImageViews[index - 1]
                imageView.leadingAnchor.constraint(equalTo: previousimageView.trailingAnchor).activate()
            }
            [
                imageView.heightAnchor.constraint(equalTo: imageScrollView.heightAnchor),
                imageView.widthAnchor.constraint(equalTo: imageScrollView.widthAnchor)
            ].activate()
        }
    }
}

extension PostBody: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / scrollView.bounds.width
        imageScrollPageControl.currentPage = Int(currentPage)
    }
}
