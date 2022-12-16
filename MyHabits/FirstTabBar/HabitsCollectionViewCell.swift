//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 18.11.2022.
//

import UIKit

protocol HVCProgressUpd: AnyObject {
    func reloadProgressBar()
}

class HabitsCollectionViewCell: UICollectionViewCell {

    weak var delegateProgressUpd: HVCProgressUpd?

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

    private var thisHabit = Habit(name: "111", date: Date(), color: .systemYellow)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setupWithHabit(with: thisHabit)
//        checkBtnDraw()
//        countLabel.text = "Счётчик: \(thisHabit.trackDates.count)"
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

        if !thisHabit.isAlreadyTakenToday {
            checkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            HabitsStore.shared.track(thisHabit)
            HabitsStore.shared.save()
            countLabel.text = "Счётчик: \(thisHabit.trackDates.count)"
        }
        self.delegateProgressUpd?.reloadProgressBar()
    }

    private func checkBtnDraw() {
        let image = thisHabit.isAlreadyTakenToday ? "checkmark.circle.fill" : "circle"
        checkButton.setBackgroundImage(UIImage(systemName: image), for: .normal)

    }

    // MARK: - Публичный метод настройки ячейки
    public func setupWithHabit(with habit: Habit) {
        self.thisHabit = habit
        self.todoLabel.text = habit.name
        self.checkButton.tintColor = habit.color
        self.todoLabel.textColor = habit.color
        self.timeLabel.text = habit.dateString
        self.countLabel.text = "Счётчик: \(thisHabit.trackDates.count)"
        checkBtnDraw()
    }

}
