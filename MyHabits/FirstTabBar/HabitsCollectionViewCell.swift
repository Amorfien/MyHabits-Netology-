//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 18.11.2022.
//

import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {

    var habitTitle = "Плавать по ночам"
    var habitColor = UIColor.systemBlue

    lazy var todoLabel: UILabel = {
        let label = UILabel()
        label.text = habitTitle
        label.numberOfLines = 2
        label.textColor = habitColor
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

    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "Счётчик: 0"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
//  FIXME: перехватить цвет
        button.tintColor = habitColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var buttonPressed: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
        setupView()
        addTarget()

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

    private func setupView() {
        contentView.addSubview(todoLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(checkButton)

        NSLayoutConstraint.activate([
//            contentView.heightAnchor.constraint(equalToConstant: 130),

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


    private func addTarget() {
        checkButton.addTarget(self, action: #selector(pressCheck), for: .touchUpInside)
    }
    @objc private func pressCheck() {
        switch buttonPressed {
        case true: do {
            self.checkButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            HabitsViewController.countOfChecks -= 1
        }
        case false: do {
            self.checkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            HabitsViewController.countOfChecks += 1
        }
        }
        buttonPressed.toggle()
    }

}
