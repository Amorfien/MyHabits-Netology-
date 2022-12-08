//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 18.11.2022.
//

import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {

    private lazy var todoLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.textColor = .orange
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в 7:30"
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var countLabel: UILabel = {
        let label = UILabel()
        label.text = "Счётчик: 0"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .orange
        button.addTarget(self, action: #selector(pressCheck), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var buttonPressed: Bool = false
    private var counter: Int = 0
    private var indx: Int = 0

    struct ViewModel {
        let habit: Habit
        var isSelected: Bool
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
//        FIXME: решить ошибки переиспользования ячеек
//        switch buttonPressed {
//        case false: checkButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
//        case true: checkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
//        }
    }

    // MARK: - Private methods

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true

        contentView.addSubview(todoLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(checkButton)

        NSLayoutConstraint.activate([
            todoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            todoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            todoLabel.widthAnchor.constraint(equalToConstant: 220),

            timeLabel.leadingAnchor.constraint(equalTo: todoLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: todoLabel.bottomAnchor, constant: 4),

            countLabel.leadingAnchor.constraint(equalTo: todoLabel.leadingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            checkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 47),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            checkButton.heightAnchor.constraint(equalToConstant: 36),
            checkButton.widthAnchor.constraint(equalToConstant: 36)
        ])
    }

    @objc private func pressCheck() {
//        let habit = HabitsStore.shared.habits[indx]
//        HabitsStore.track(habit)

        let name = buttonPressed ? "circle" : "checkmark.circle.fill"
        checkButton.setBackgroundImage(UIImage(systemName: name), for: .normal)

        // временный метод счётчика
        HabitsViewController.countOfChecks = buttonPressed ? HabitsViewController.countOfChecks - 1 : HabitsViewController.countOfChecks + 1
        if !buttonPressed { counter += 1 }
        countLabel.text = "Счётчик: \(counter)"

        buttonPressed.toggle()
    }

    private func setupCheckBtn(with model: ViewModel) {
        
        let image = model.isSelected ? "circle" : "checkmark.circle.fill"
        checkButton.setBackgroundImage(UIImage(systemName: image), for: .normal)
//        model.habit.isAlreadyTakenToday
    }

//    MARK: - Публичный метод настройки ячейки
    func setCell(name: String, color: UIColor, dateString: String, checkToday: Bool) {
        self.todoLabel.text = name
        self.checkButton.tintColor = color
        self.todoLabel.textColor = color
        self.timeLabel.text = dateString
        self.buttonPressed = checkToday
    }

}
