// RecomendationsCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с набором рекомендаций пользователю
final class RecomendationsCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Рекомендуем вам"
        static let allText = "Все"
    }

    // MARK: - Visual Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .verdanaBold?.withSize(10)
        label.text = Constants.titleText
        return label
    }()

    private let allLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .right
        label.font = .verdanaBold?.withSize(10)
        label.text = Constants.allText
        return label
    }()

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInset.left = 17
        scroll.contentInset.right = 17
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .clear
        return scroll
    }()

    // MARK: - Private Properties

    private var recomendationViews: [RecomendationView] = []

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

    private func configureUI() {
        contentView.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.8745098039, blue: 0.9333333333, alpha: 1)
        contentView.addSubviews(titleLabel, allLabel, scrollView)
    }

    func configure(with recomendations: [Recomendation]) {
        guard recomendations.count != recomendationViews.count else { return }

        for index in 0 ..< recomendations.count {
            let recomendationCell = RecomendationView()
            recomendationCell.configure(with: recomendations[index])
            recomendationViews.append(recomendationCell)
        }

        scrollView.addSubviews(recomendationViews)
        configureCellsLayout()
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: titleLabel, allLabel, scrollView)
        configureTitleLabelLayout()
        configureAllLabelLayout()
        configureScrollViewLayout()
    }

    private func configureTitleLabelLayout() {
        [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
        ].activate()
    }

    private func configureAllLabelLayout() {
        [
            allLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            allLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ].activate()
    }

    private func configureScrollViewLayout() {
        [
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25)
        ].activate()
    }

    private func configureCellsLayout() {
        UIView.doNotTAMIC(for: recomendationViews)
        for (index, cell) in recomendationViews.enumerated() {
            switch index {
            case 0:
                cell.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).activate()
            case recomendationViews.count - 1:
                cell.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).activate()
                fallthrough
            default:
                let previousCell = recomendationViews[index - 1]
                cell.leadingAnchor.constraint(equalTo: previousCell.trailingAnchor, constant: 20).activate()
            }
            [
                cell.topAnchor.constraint(equalTo: scrollView.topAnchor),
                cell.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            ].activate()
        }
        scrollView.heightAnchor.constraint(equalTo: recomendationViews[0].heightAnchor).activate()
    }
}
