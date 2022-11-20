//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 18.11.2022.
//

import UIKit

class HabitViewController: UIViewController {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.textColor = .blue
        textField.returnKeyType = .done
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let colorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var colorPicker: UIColorPickerViewController = {
        let cPicker = UIColorPickerViewController()
        cPicker.delegate = self
        return cPicker
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let setTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var datePickerLabel: UILabel = {
        let label = UILabel()
        label.text = "11:15 PM"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 161/257, green: 22/257, blue: 204/257, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var pickerView: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку название выбранной привычки?", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupNavigation()
        setupUI()
        addTarget()
        setupGestures()
        alertAction()

        getTimeFromPicker()

    }

    @objc private func getTimeFromPicker() {

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        datePickerLabel.text = formatter.string(from: pickerView.date)
        keyboardHide()
    }

    private func setupNavigation() {
        navigationController?.isToolbarHidden = false
        navigationItem.title = "Создать"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor(red: 161/257, green: 22/257, blue: 204/257, alpha: 1)
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(closeHabit))
        navigationItem.leftBarButtonItem = cancelButton
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabit))
        navigationItem.rightBarButtonItem = saveButton

        navigationController?.toolbar.isHidden = true
    }

    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(colorLabel)
        view.addSubview(colorButton)
        view.addSubview(timeLabel)
        view.addSubview(setTimeLabel)
        view.addSubview(datePickerLabel)
        view.addSubview(pickerView)
        view.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46),

            colorLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            colorLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 83),

            colorButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            colorButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 108),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),

            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 153),

            setTimeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            setTimeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 178),

            datePickerLabel.topAnchor.constraint(equalTo: setTimeLabel.topAnchor),
            datePickerLabel.leadingAnchor.constraint(equalTo: setTimeLabel.trailingAnchor, constant: 6),

            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 215),
            pickerView.heightAnchor.constraint(equalToConstant: 216),

            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -52),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func alertAction() {
        let okAction = UIAlertAction(title: "Отмена", style: .default)
        let cancelAction = UIAlertAction(title: "Удалить", style: .destructive) {_ in
            self.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
    }

    private func addTarget() {
        deleteButton.addTarget(self, action: #selector(tapOnAlert), for: .touchUpInside)
        colorButton.addTarget(self, action: #selector(tapOnColor), for: .touchUpInside)
        pickerView.addTarget(self, action: #selector(getTimeFromPicker), for: .valueChanged)

    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func tapOnAlert() {
        self.present(alertController, animated: true)
    }

    @objc private func tapOnColor() {
        present(colorPicker, animated: true)
        keyboardHide()
    }

    @objc private func tapOnView() {
        keyboardHide()
    }

    @objc private func closeHabit() {
        self.dismiss(animated: true)
    }

    @objc private func saveHabit() {
        self.dismiss(animated: true)
    }

    private func keyboardHide() {
        view.endEditing(true)
    }

}

extension HabitViewController: UIColorPickerViewControllerDelegate {

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        colorButton.backgroundColor = color
    }

}

extension HabitViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyboardHide()
        return true
    }

}
