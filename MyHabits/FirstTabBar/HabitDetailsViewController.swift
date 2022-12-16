//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 19.11.2022.
//

import UIKit

protocol HabitDetailsViewControllerDelegate: AnyObject {
    func didDeleteHabit(index: Int)
}

protocol DetailVCUpdateDelegate: AnyObject {
    func updateCell(updIndex: Int)
}

class HabitDetailsViewController: UIViewController {

    weak var delegateDelete: HabitDetailsViewControllerDelegate?
    weak var delegateUpdate: DetailVCUpdateDelegate?
    
    // MARK: - UI elements

    private lazy var detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Properties
//            заполняются данными из ячейки HabitsCollectionViewCell
    private var index: Int
    private lazy var thisHabit = HabitsStore.shared.habits[index]

    // MARK: - Life cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)

        setupNavigation()
        setupView()

    }

    // скорее всего это дикая ошибка. Вызов делегата нужно было засунуть в dismiss по аналогии с удалением. Или нужно достучаться до нативной кнопки "назад" и добавить ей селектор
    deinit {
        self.delegateUpdate?.updateCell(updIndex: index)
    }

    init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
        self.thisHabit = HabitsStore.shared.habits[index]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupNavigation() {
        navigationController?.isToolbarHidden = false
        navigationItem.title = thisHabit.name
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
        let editButton = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
        navigationItem.rightBarButtonItem = editButton

        navigationController?.toolbar.isHidden = true
    }

    private func setupView() {
        view.addSubview(detailTableView)

        NSLayoutConstraint.activate([
            detailTableView.topAnchor.constraint(equalTo: view.topAnchor),
            detailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func editHabit() {
        let habitViewController = HabitViewController(habit: thisHabit, index: index)
        habitViewController.delegateClose = self
        navigationController?.presentOnRoot(with: habitViewController)
    }

}

// MARK: - Extensions

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        let reverseDates: [Date] = HabitsStore.shared.dates.reversed()
        cell.accessoryType = HabitsStore.shared.habit(thisHabit, isTrackedIn: reverseDates[indexPath.row]) ? .checkmark : .none

        cell.selectionStyle = .none
        cell.tintColor = #colorLiteral(red: 0.6902361512, green: 0, blue: 0.8297754526, alpha: 1)

        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YYYY"
        formatter.locale = .init(identifier: "ru_RU")

        switch indexPath.row {
        case 0: cell.textLabel?.text = "Сегодня"
        case 1: cell.textLabel?.text = "Вчера"
        case 2: cell.textLabel?.text = "Позавчера"
        default: cell.textLabel?.text = formatter.string(from: reverseDates[indexPath.row])
        }

        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }

}

//MARK: - My delegates

extension HabitDetailsViewController: CloseDetailViewControllerDelegate {
    func popToRootVC() {
        navigationController?.popToRootViewController(animated: true)
        self.delegateDelete?.didDeleteHabit(index: index)
    }
}
