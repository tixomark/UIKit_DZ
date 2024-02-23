// StoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран спросмотра истории
final class StoryViewController: UIViewController {
    // MARK: - Visual Components

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.closeButon, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    private let storyProgressView: UIProgressView = {
        let view = UIProgressView()
        view.setProgress(0, animated: false)
        view.progressTintColor = .white
        view.trackTintColor = .opaqueSeparator
        return view
    }()

    private let storyIconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 13.5
        let backgroungLayer = CALayer()
        backgroungLayer.backgroundColor = UIColor.white.cgColor
        backgroungLayer.frame = view.frame.insetBy(dx: -3, dy: -3)
        backgroungLayer.cornerRadius = 15
        backgroungLayer.masksToBounds = true
        view.layer.addSublayer(backgroungLayer)
        return view
    }()

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .opaqueSeparator
        label.font = .verdana?.withSize(10)
        label.textAlignment = .left
        return label
    }()

    private let storyImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = .galleryImage1
        view.clipsToBounds = true
        return view
    }()

    // MARK: - Private Properties

    private var timer = Timer()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func configure(with story: UserStory) {
        storyIconImageView.image = UIImage(story.imageName)
        captionLabel.text = story.caption
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(storyImageView, storyProgressView, storyIconImageView, captionLabel, closeButton)
        createTimer()
    }

    private func configureLayout() {
        UIView.doNotTAMIC(for: storyImageView, storyProgressView, storyIconImageView, captionLabel, closeButton)
        configureStoryImageViewLayout()
        configureStoryProgressViewLayout()
        configureStoryIconImageViewLayout()
        configureCaptionLabelLayout()
        configureCloseButtonLayout()
    }

    private func configureStoryImageViewLayout() {
        [
            storyImageView.topAnchor.constraint(equalTo: view.topAnchor),
            storyImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            storyImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            storyImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].activate()
    }

    private func configureStoryProgressViewLayout() {
        [
            storyProgressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
            storyProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            storyProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            storyProgressView.heightAnchor.constraint(equalToConstant: 3)
        ].activate()
    }

    private func configureStoryIconImageViewLayout() {
        [
            storyIconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            storyIconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            storyIconImageView.heightAnchor.constraint(equalToConstant: 26),
            storyIconImageView.widthAnchor.constraint(equalTo: storyIconImageView.heightAnchor)
        ].activate()
    }

    private func configureCaptionLabelLayout() {
        [
            captionLabel.centerYAnchor.constraint(equalTo: storyIconImageView.centerYAnchor),
            captionLabel.leadingAnchor.constraint(equalTo: storyIconImageView.trailingAnchor, constant: 9)
        ].activate()
    }

    private func configureCloseButtonLayout() {
        [
            closeButton.centerYAnchor.constraint(equalTo: storyIconImageView.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor)
        ].activate()
    }

    private func createTimer() {
        timer = Timer(timeInterval: 0.1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
    }

    @objc private func fireTimer() {
        if storyProgressView.progress != 1 {
            UIView.animate(withDuration: 0.1) {
                self.storyProgressView.progress += 0.05
            }
        } else if storyProgressView.progress == 1.0 {
            dismiss(animated: true)
        }
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}
