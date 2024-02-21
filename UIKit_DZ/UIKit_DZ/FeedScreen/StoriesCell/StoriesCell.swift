// StoriesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка таблицы содержащяя набор сторис
final class StoriesCell: UITableViewCell {
    // MARK: - Visual Components

    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInset.left = 12
        scroll.contentInset.right = 12
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .systemBackground
        return scroll
    }()

    // MARK: - Private Properties

    private var storyViews: [StoryView] = []

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

    // MARK: - Public Methods

    func configure(with stories: [Story]) {
        guard stories.count != storyViews.count else { return }
        let numberOfItems = stories.count
        let createStoryView = CreateStoryView()
        createStoryView.configure(with: stories[0])
        storyViews.append(createStoryView)

        for index in 1 ..< numberOfItems {
            let storyCell = StoryView()
            storyCell.configure(with: stories[index])
            storyViews.append(storyCell)
        }

        scrollView.addSubviews(storyViews)
        configureCellsLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubview(scrollView)
    }

    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: scrollView)
        [
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].activate()
    }

    private func configureCellsLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: storyViews)
        for (index, cell) in storyViews.enumerated() {
            switch index {
            case 0:
                cell.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).activate()
            case storyViews.count - 1:
                cell.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).activate()
                fallthrough
            default:
                let previousCell = storyViews[index - 1]
                cell.leadingAnchor.constraint(equalTo: previousCell.trailingAnchor, constant: 8).activate()
            }
            [
                cell.topAnchor.constraint(equalTo: scrollView.topAnchor),
                cell.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            ].activate()
        }
        scrollView.heightAnchor.constraint(equalTo: storyViews[0].heightAnchor).activate()
    }
}
