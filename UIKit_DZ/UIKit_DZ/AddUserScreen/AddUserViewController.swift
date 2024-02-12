// AddUserViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol AddUserViewControllerDelegate: AnyObject {
    /// Отдает только созданного человека на обработку своему делегату
    func didSuccessfulyAddPerson(_ person: PersonData)
}

/// Контроллер для ввода информации о новом пользователе.
final class AddUserViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let changePhotoText = "Change Photo"
        static let enterTelegramText = "Please enter Telegram"
        static let formFieldsSetupData = [
            (title: "Name Surname", placeholder: "Typing Name Surname"),
            (title: "Birthday", placeholder: "Typing Birthday"),
            (title: "Age", placeholder: "Typing Age"),
            (title: "Gender", placeholder: "Typing Gender"),
            (title: "Telegram", placeholder: "Typing Telegram")
        ]
        static let genders = ["Male", "Female"]
    }

    // MARK: - Public Properties

    weak var delegate: AddUserViewControllerDelegate?

    // MARK: - Private Properties

    private let navigationBar = UINavigationBar()

    /// Изображение нового человека
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(.placeholderUserImage)
        imageView.layer.cornerRadius = 125 / 2
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    /// Кнопка смены изображения
    private let changePhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle(Constants.changePhotoText, for: .normal)
        button.titleLabel?.font = .verdana?.withSize(16)
        return button
    }()

    /// Массив содержащий все пять вью ввода данных
    private var formFields: [FormFieldView] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculateAndSetUpFrames()
    }

    // MARK: - Private Methods

    private func setUpUI() {
        view.backgroundColor = .systemBackground

        let navigationItem = UINavigationItem()
        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTapBarButtonItem(_:))
        )
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapBarButtonItem(_:))
        )

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButton

        navigationBar.items = [navigationItem]
        navigationBar.setValue(true, forKey: "hidesShadow")
        navigationBar.isTranslucent = false

        view.addSubviews(navigationBar, headerImageView, changePhotoButton)

        for formFieldData in Constants.formFieldsSetupData {
            let field = FormFieldView()
            field.annotationLabel.text = formFieldData.title
            field.annotationLabel.textColor = .black
            field.textField.placeholder = formFieldData.placeholder
            formFields.append(field)
            view.addSubview(field)
        }

        setInputViewsForFormFields()
    }

    /// Настраивает пикеры для текстовых полей
    private func setInputViewsForFormFields() {
        let datePicker = createDatePicker()
        formFields[1].textField.inputView = datePicker
        let dateToolBar = createToolBar(withTitle: "Done", #selector(didEndPicking))
        formFields[1].textField.inputAccessoryView = dateToolBar

        let agePicker = createPicker()
        agePicker.tag = 0
        formFields[2].textField.inputView = agePicker
        let ageToolBar = createToolBar(withTitle: "OK", #selector(didEndPicking))
        formFields[2].textField.inputAccessoryView = ageToolBar

        let genderPicker = createPicker()
        genderPicker.tag = 1
        formFields[3].textField.inputView = genderPicker
        formFields[3].textField.inputAccessoryView = ageToolBar

        formFields[4].textField.addTarget(self, action: #selector(showEnterTelegramAlert), for: .editingDidBegin)
    }

    /// Создает дата пикер для поля ввода даты
    private func createDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(valueChangedIn(_:)), for: .valueChanged)
        return datePicker
    }

    /// Создает пикер и прокидывает себя в далагат и датасурс
    private func createPicker() -> UIPickerView {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }

    /// Создвет ToolBar с заданным именем и селектором
    private func createToolBar(withTitle title: String, _ selector: Selector) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: title,
            style: .plain,
            target: self,
            action: selector
        )
        toolBar.setItems([.flexibleSpace(), doneButton], animated: false)
        return toolBar
    }

    /// Для всех сабвью рассчитывает фреймы и размещает их соответственно
    /// В теле функции в именах иcпользуется сокращение V - View
    private func calculateAndSetUpFrames() {
        navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        /// Рассчитывает Х коодинату исходя из ширины дочернего вью, для центрирования относительно self.view
        func centerInViewFor(_ width: CGFloat) -> CGFloat {
            (view.bounds.width - width) / 2
        }
        let viewWidth = view.bounds.width

        let imageVSide: CGFloat = 125
        let imageVSize = CGSize(width: imageVSide, height: imageVSide)
        let imageVOrigin = CGPoint(x: centerInViewFor(imageVSide), y: 70)
        headerImageView.frame = CGRect(origin: imageVOrigin, size: imageVSize)

        let changePhotoBSize = CGSize(width: viewWidth - 200, height: 20)
        let changePhotoBOrigin = CGPoint(x: (viewWidth - changePhotoBSize.width) / 2, y: headerImageView.frame.maxY + 8)
        changePhotoButton.frame = CGRect(origin: changePhotoBOrigin, size: changePhotoBSize)

        // ширина вью с отступами спарва и слева
        let screenWideVWidth = viewWidth - 40
        // х координата отчентрированных вью с отступами спарва и слева
        let screenWideVOriginX = centerInViewFor(screenWideVWidth)

        for (index, formField) in formFields.enumerated() {
            var formFieldSize = formField.frame.size
            formFieldSize.width = screenWideVWidth
            let formFieldOriginY = changePhotoButton.frame.maxY + 20 + CGFloat(index) * (formFieldSize.height + 20)
            let formFieldOrigin = CGPoint(x: screenWideVOriginX, y: formFieldOriginY)
            formField.frame = CGRect(origin: formFieldOrigin, size: formFieldSize)
        }
    }

    @objc private func didEndPicking() {
        formFields[1].textField.resignFirstResponder()
        formFields[2].textField.resignFirstResponder()
        formFields[3].textField.resignFirstResponder()
    }

    @objc private func didTapBarButtonItem(_ sender: UIBarButtonItem) {
        switch sender {
        case navigationBar.items?.first?.leftBarButtonItem:
            dismiss(animated: true)
        case navigationBar.items?.first?.rightBarButtonItem:
            let person = PersonData(
                name: formFields[0].textField.text ?? "",
                birthday: formFields[1].textField.text?.toDate() ?? Date()
            )
            delegate?.didSuccessfulyAddPerson(person)
            dismiss(animated: true)
        default:
            break
        }
    }

    @objc private func valueChangedIn(_ sender: UIDatePicker) {
        formFields[1].textField.text = sender.date.formatted(date: .numeric, time: .omitted)
    }

    /// Создает и показывает алерт в просбой ввести телеграм
    @objc private func showEnterTelegramAlert() {
        let alert = UIAlertController(title: Constants.enterTelegramText)
        let cancelAction = UIAlertAction(title: "Cancel")
        let okAction = UIAlertAction(title: "Ok") { _ in
            self.formFields[4].textField.text = alert.textFields?.first?.text
        }

        alert.addTextField { textfield in
            textfield.placeholder = Constants.formFieldsSetupData[4].placeholder
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.preferredAction = alert.actions.last
        present(alert, animated: true)
    }
}

extension AddUserViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            130
        } else {
            Constants.genders.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            row.description
        } else {
            Constants.genders[row]
        }
    }
}

extension AddUserViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            formFields[2].textField.text = row.description
        } else {
            formFields[3].textField.text = Constants.genders[row]
        }
    }
}
