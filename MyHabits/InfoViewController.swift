//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 17.11.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Привычка за 21 день"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let infoText: UITextView = {
        let info = UITextView()
        info.font = UIFont.systemFont(ofSize: 17)
        info.isScrollEnabled = false
        info.text = """
Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

1. Провести 1 день без обращения
к старым привычкам, стараться вести себя так, как будто цель, загаданная
в перспективу, находится на расстоянии шага.

2. Выдержать 2 дня в прежнем состоянии самоконтроля.

3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче,
с чем еще предстоит серьезно бороться.

4. Поздравить себя с прохождением первого серьезного порога в 21 день.
За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
"""
        info.translatesAutoresizingMaskIntoConstraints = false
        return info
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/257, green: 242/257, blue: 247/257, alpha: 1)
        navigationController?.isToolbarHidden = false
        navigationItem.title = "Информация"
        setupUI()
    }

    private func setupUI() {
        view.addSubview(whiteView)
        view.addSubview(titleLabel)
        view.addSubview(infoText)

        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            infoText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            infoText.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            infoText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoText.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor)
        ])
    }
}
