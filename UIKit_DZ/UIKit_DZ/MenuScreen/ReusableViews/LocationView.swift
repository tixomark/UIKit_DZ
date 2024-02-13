// LocationView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вынесенное в отдельный класс представление, просящее дать доступ к геолокации пользователя
final class LocationView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Адреса кофеен"
        static let infoText = "Разрѣшите доступъ къ ​геолокаціи для поиска ближайшей кофейни"
    }

    // MARK: - Visual Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 150, height: 15)
        label.frame.origin = CGPoint(x: 15, y: 12)

        label.text = Constants.titleText
        label.textColor = .black
        label.font = UIFont(name: "Verdana-Bold", size: 12)
        label.textAlignment = .left
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 260, height: 30)
        label.frame.origin = CGPoint(x: 15, y: 30)

        label.text = Constants.infoText
        label.textColor = #colorLiteral(red: 0.6117647059, green: 0.631372549, blue: 0.6588235294, alpha: 1)
        label.font = UIFont(name: "Verdana", size: 12)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    private let locationImageView: UIImageView = {
        let view = UIImageView()
        view.frame.size = CGSize(width: 21, height: 29)
        view.frame.origin = CGPoint(x: 289, y: 19)
        view.image = UIImage(.locationPinIcon)
        view.contentMode = .scaleAspectFit
        return view
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }

    // MARK: - Private Methods

    private func setUpUI() {
        layer.cornerRadius = 16
        backgroundColor = .locationVeiwBackground
        addSubviews(titleLabel, infoLabel, locationImageView)
    }
}
