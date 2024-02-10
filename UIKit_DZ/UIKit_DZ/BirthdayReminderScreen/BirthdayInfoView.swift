// BirthdayInfoView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка отображающая информацию о человеке и его дне рождения
final class BirthdayInfoView: UIView {
    // MARK: - Private Properties

    /// Изображение человека, чьи данные сейчас показываются в данном вью
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 75 / 2
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.opaqueSeparator.cgColor
        return view
    }()

    ///  Содержит имя текущего человека
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold?.withSize(16)
        label.textAlignment = .left
        return label
    }()

    /// Содержит информацию о дне рождения и количестве лет
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana?.withSize(16)
        label.textAlignment = .left
        return label
    }()

    /// Отображение количества дней оставшихся до дня рождения
    private var countdownLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold?.withSize(16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .accentPurple
        return label
    }()

    /// Изображение которое в может заменять countdownLabel
    private var indicatorImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.image = UIImage(.cake)
        return view
    }()

    // MARK: - Life Cycle

    init() {
        let size = CGSize(width: 0, height: 75)
        let frame = CGRect(origin: .zero, size: size)
        super.init(frame: frame)
        setUpUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        calculateAndApplySubviewsFrames()
    }

    // MARK: - Public Methods

    /// Устанавливает изображения и тексты 
    func setUpWith(image: UIImage?, name: String, age: String, countdown: Int) {
        imageView.image = image
        nameLabel.text = name
        ageLabel.text = age

        if countdown == 0 {
            countdownLabel.isHidden = true
            indicatorImageView.isHidden = false
        } else {
            countdownLabel.text = "\(countdown) days"
        }
    }

    // MARK: - Private Methods

    private func setUpUI() {
        addSubviews(imageView, nameLabel, ageLabel, countdownLabel, indicatorImageView)
        indicatorImageView.isHidden = true
    }

    /// Рассчитывает размеры и положения сабвью данного отображения. И распологает все сабвью соответственно.
    private func calculateAndApplySubviewsFrames() {
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: 75, height: 75))

        let countdownLabelSize = CGSize(width: 44, height: 44)
        let countdownLabelOrigin = CGPoint(
            x: bounds.maxX - countdownLabelSize.width,
            y: bounds.midY - countdownLabelSize.height / 2
        )
        countdownLabel.frame = CGRect(origin: countdownLabelOrigin, size: countdownLabelSize)
        indicatorImageView.frame = countdownLabel.frame

        let labelWidth = bounds.width - imageView.frame.width - countdownLabel.frame.width - 3 - 8
        let labelHeight: CGFloat = 20
        let labelSize = CGSize(width: labelWidth, height: labelHeight)
        let labelOriginX = imageView.frame.size.width + 8

        let nameLabelOriginY = bounds.midY - 4 - labelSize.height
        let nameLabelOrigin = CGPoint(x: labelOriginX, y: nameLabelOriginY)
        nameLabel.frame = CGRect(origin: nameLabelOrigin, size: labelSize)

        let ageLabelOriginY = bounds.midY + 4
        let ageLabelOrigin = CGPoint(x: labelOriginX, y: ageLabelOriginY)
        ageLabel.frame = CGRect(origin: ageLabelOrigin, size: labelSize)
    }
}
