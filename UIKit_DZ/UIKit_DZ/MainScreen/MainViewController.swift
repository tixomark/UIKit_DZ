// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Main screen view
final class MainViewController: UIViewController {
    // MARK: - Constants

    private let startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .customLightGreen
        button.setTitle("Начать", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        return button
    }()

    private let originalWordView = LabeledView()
    private let revertedWordView = LabeledView()

    // MARK: - Private Properties

    private var wordReverter = ReverterModel()
    private var enterYourWordAlertOkAktion: UIAlertAction?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setFrameOfStartButton()
        setFramesOfWordViews()
    }

    // MARK: - Private Methods

    private func setUpUI() {
        view.backgroundColor = .systemBackground

        originalWordView.setAnnotationTextTo("Вы ввели слово")
        originalWordView.isHidden = true
        originalWordView.alpha = 0
        view.addSubview(originalWordView)

        revertedWordView.setAnnotationTextTo("А вот что получится, если читать справа налево")
        revertedWordView.isHidden = true
        revertedWordView.alpha = 0
        view.addSubview(revertedWordView)

        startButton.addTarget(self, action: #selector(didTapStartButton(_:)), for: .touchUpInside)
        view.addSubview(startButton)
    }

    private func showEnterYourWordAlert() {
        let alert = UIAlertController(
            title: "Введите ваше слово",
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField { [unowned self] textField in
            textField.placeholder = "Введите слово"
            textField.addTarget(self, action: #selector(textDidChangeIn(_:)), for: .editingChanged)
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        alert.addAction(cancelAction)

        enterYourWordAlertOkAktion = UIAlertAction(title: "Ок", style: .cancel) { [unowned self] _ in
            wordReverter.updateWord(alert.textFields?.first?.text)
            originalWordView.setInfoLabelTextTo(wordReverter.word)
            revertedWordView.setInfoLabelTextTo(wordReverter.reversedWord)
            updateScreenToShowWordViewsWithAnimation()
        }
        enterYourWordAlertOkAktion?.isEnabled = false
        if let enterYourWordAlertOkAktion {
            alert.addAction(enterYourWordAlertOkAktion)
        }

        present(alert, animated: true)
    }

    private func setFrameOfStartButton() {
        let buttonHeight: CGFloat = 44
        let insetToParentView: CGFloat = 40

        var originY = view.bounds.maxY - buttonHeight - view.safeAreaInsets.bottom - insetToParentView
        if originalWordView.isHidden, revertedWordView.isHidden {
            originY = view.bounds.midY - buttonHeight / 2
        }

        let buttonSize = CGSize(
            width: view.bounds.width - insetToParentView,
            height: buttonHeight
        )
        let buttonOrigin = CGPoint(
            x: view.bounds.midX - buttonSize.width / 2,
            y: originY
        )
        startButton.frame = CGRect(origin: buttonOrigin, size: buttonSize)
    }

    private func setFramesOfWordViews() {
        let wiewWidth = view.bounds.width - 100
        let originalWordViewOrigin = CGPoint(
            x: view.bounds.midX - wiewWidth / 2,
            y: 106
        )
        originalWordView.frame = CGRect(
            origin: originalWordViewOrigin,
            size: CGSize(
                width: wiewWidth,
                height: originalWordView.frame.height
            )
        )

        let revertedWordViewOrigin = CGPoint(
            x: view.bounds.midX - wiewWidth / 2,
            y: originalWordView.frame.maxY + 62
        )
        revertedWordView.frame = CGRect(
            origin: revertedWordViewOrigin,
            size: CGSize(
                width: wiewWidth,
                height: revertedWordView.frame.height
            )
        )
    }

    private func updateScreenToShowWordViewsWithAnimation() {
        guard originalWordView.isHidden, revertedWordView.isHidden else { return }

        var adjustedStartButtonFrame = startButton.frame
        adjustedStartButtonFrame.origin.y = view.bounds.maxY -
            startButton.frame.size.height -
            view.safeAreaInsets.bottom - 40

        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut) {
            self.startButton.frame = adjustedStartButtonFrame
        }

        originalWordView.isHidden = false
        revertedWordView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.originalWordView.alpha = 1
            self.revertedWordView.alpha = 1
        }
    }

    @objc private func didTapStartButton(_ sender: UIButton) {
        showEnterYourWordAlert()
    }

    @objc private func textDidChangeIn(_ sender: UITextField) {
        guard let text = sender.text, text.count > 1 else {
            enterYourWordAlertOkAktion?.isEnabled = false
            return
        }
        enterYourWordAlertOkAktion?.isEnabled = true
    }
}
