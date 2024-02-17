// FootSizeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Представление выбора размера ноги пользователя
final class FootSizeViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let title = "Размер ноги"
        static let sizes = ["37", "38", "39"]
        static let saveButtonTitle = "Сохранить"
        static let closeImage: UIImage = .init(systemName: "xmark") ?? UIImage()
    }

    // MARK: - Visual Components

    private lazy var overlayView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 20
        whiteView.dropShadow()
        return whiteView
    }()

    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.closeImage, for: .normal)
        button.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = Constants.title
        title.textColor = .black
        title.font = .verdanaBold?.withSize(16)
        return title
    }()

    private lazy var sizePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()

    private lazy var saveButton: SubmissionButton = {
        var button = SubmissionButton()
        button.setTitle(Constants.saveButtonTitle, for: .normal)
        button.dropShadow()
        button.addTarget(self, action: #selector(tappedButtonSave), for: .touchUpInside)
        button.backgroundColor = .accentPink
        button.layer.cornerRadius = 20
        return button
    }()

    // MARK: - Public Properties

    var dataTransmissionHandler: ((_ size: String) -> ())?

    // MARK: - Private Properties

    private var sizeFoot = ""

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Private Methods

    private func configure() {
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.addSubview(overlayView)
        overlayView.addSubviews(titleLabel, sizePicker, saveButton, dismissButton)
        makeAnchorOverlayView()
        makeAnchorTitleLabel()
        makeAnchorsizePicker()
        makeAnchorsizeSaveButton()
        makeAnchorCloseButton()
    }

    @objc private func closeViewController() {
        dismiss(animated: true)
    }

    @objc private func tappedButtonSave() {
        dataTransmissionHandler?("\(sizeFoot)")
        dismiss(animated: true)
    }
}

// MARK: - Setup Anchor

extension FootSizeViewController {
    private func makeAnchorOverlayView() {
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -17).isActive = true
        overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func makeAnchorCloseButton() {
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 22).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -20).isActive = true
    }

    private func makeAnchorTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 22).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor).isActive = true
    }

    private func makeAnchorsizePicker() {
        sizePicker.translatesAutoresizingMaskIntoConstraints = false
        sizePicker.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor).isActive = true
        sizePicker.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor).isActive = true
        sizePicker.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor).isActive = true
    }

    private func makeAnchorsizeSaveButton() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -31).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 62).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -62).isActive = true
    }
}

// MARK: - UIPickerViewDataSource

extension FootSizeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Constants.sizes.count
    }
}

// MARK: - UIPickerViewDelegate,

extension FootSizeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Constants.sizes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sizeFoot = Constants.sizes[row]
        dataTransmissionHandler?("\(sizeFoot)")
    }
}
