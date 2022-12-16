//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 18.11.2022.
//

import UIKit

protocol HabitViewControllerDelegate: AnyObject {
    func didAddNewHabit()
//    func didDeleteHabit(index: Int) // Не  уверен что её нужно прикручивать сюда
}

// Второй делегат, отвечающий за закрытие следующего экрана
protocol CloseDetailViewControllerDelegate: AnyObject {
    func popToRootVC()
}

class HabitViewController: UIViewController {

    weak var delegate: HabitViewControllerDelegate?
    weak var delegateClose: CloseDetailViewControllerDelegate?

    // MARK: - UI elements

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
        textField.textColor = .black
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

    private lazy var colorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tapOnColor), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var colorPicker: UIColorPickerViewController = {
        let cPicker = UIColorPickerViewController()
        cPicker.selectedColor = color
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
        label.textColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var pickerView: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.date = date ?? Date()
        picker.addTarget(self, action: #selector(getTimeFromPicker), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(tapOnAlert), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var alertController = UIAlertController(title: "Удалить привычку",
                                                         message: "Вы хотите удалить привычку?",
                                                         preferredStyle: .alert)

    private var index: Int?
    private var name: String?
    private var color: UIColor
    private var deleteIsHiden: Bool
    private var isTyping: Bool
    private var date: Date?

    init(habit: Habit?, index: Int?) {
        self.index = index
        self.name = habit?.name// ?? ""
        self.color = habit?.color ?? .orange
        self.deleteIsHiden = index == nil ? true : false
        self.isTyping = index == nil ? true : false
        self.date = habit?.date
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupNavigation()
        setupUI()
        setupGestures()
        alertAction()

        getTimeFromPicker()

        habitOption()
    }

    // MARK: - Private methods

    @objc private func getTimeFromPicker() {

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        datePickerLabel.text = formatter.string(from: pickerView.date)
        keyboardHide()
    }

    private func setupNavigation() {
        navigationController?.isToolbarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
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
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

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

            deleteButton.topAnchor.constraint(greaterThanOrEqualTo: pickerView.bottomAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -52),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

//    MARK: - Удаление привычки
    private func alertAction() {
        let okAction = UIAlertAction(title: "Отмена", style: .default)
        let cancelAction = UIAlertAction(title: "Удалить", style: .destructive) {_ in
            self.dismiss(animated: true){
//                self.delegate?.didDeleteHabit(index: self.index!)
                self.delegateClose?.popToRootVC()
            }
            HabitsStore.shared.habits.remove(at: self.index!)
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func tapOnAlert() {
        alertController.message = "Вы хотите удалить привычку \"\(nameTextField.text ?? "")\"?"
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
        guard nameTextField.text != "" else { return }
        createHabit()
        self.dismiss(animated: true) {
            self.delegate?.didAddNewHabit()
        }
    }

    private func keyboardHide() {
        view.endEditing(true)
    }

//    MARK: - Создание новой привычки
    func createHabit() {
        let store = HabitsStore.shared
        let newHabit = Habit(name: nameTextField.text!,
                             date: pickerView.date,
                             color: colorButton.backgroundColor!)
        if self.index == nil {
//            store.habits.append(newHabit)
            store.habits.insert(newHabit, at: 0)
        } else {
            store.habits.remove(at: index!)
            store.habits.insert(newHabit, at: index!)
        }
    }

//    MARK: - Публичный метод заполнения полей и заголовка Создать/Править
    func habitOption() {
        navigationItem.title = (index == nil) ? "Создать" : "Править"
        nameTextField.text = name
        nameTextField.textColor = color
        colorButton.backgroundColor = color
        deleteButton.isHidden = deleteIsHiden
        if isTyping {
            nameTextField.becomeFirstResponder()
        }
    }

}

// MARK: - Extensions

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        colorButton.backgroundColor = color
        nameTextField.textColor = color
    }
}

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyboardHide()
        return true
    }
}
