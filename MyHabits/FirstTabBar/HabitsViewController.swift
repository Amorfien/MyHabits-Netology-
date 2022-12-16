//
//  ViewController.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 17.11.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    // MARK: - UI elements

    private var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16)
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height)
        return layout
    }()

    private lazy var habitsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressCell")
        collectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: "HabitsCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

//    static var countOfChecks: Int = 0

    // MARK: - Life cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        setupNavigation()
        setupUI()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Private methods

    private func setupNavigation() {
        navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButton))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
    }

    private func setupUI() {
        view.addSubview(habitsCollectionView)
        NSLayoutConstraint.activate([
            habitsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    @objc private func plusButton() {
        let habitViewController = HabitViewController(habit: nil, index: nil)

        habitViewController.delegate = self

        presentOnRoot(with: habitViewController)
    }

}

// MARK: - Extensions

extension UIViewController {
    func presentOnRoot(with viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .automatic
        self.present(navigationController, animated: true)
    }
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? 1 : HabitsStore.shared.habits.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCell", for: indexPath) as? ProgressCollectionViewCell
            let habits = HabitsStore.shared.habits
            if habits.count > 0 {
//                let percent: Float = Float(HabitsViewController.countOfChecks) / Float(habits.count)
                let percent = HabitsStore.shared.todayProgress
                cell!.setProgress(percent: percent)
            } else {
                cell!.setProgress(percent: nil)
            }
            return cell!

        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitsCell", for: indexPath)
            if let cell = cell as? HabitsCollectionViewCell {
                cell.delegateProgressUpd = self
                let habit = HabitsStore.shared.habits[indexPath.item]
                cell.setupWithHabit(with: habit)
                
//               let model = Model(iD: indexPath.item, habit: HabitsStore.shared.habits[indexPath.item])
//                cell.setupWithModel(with: model)
//                cell.setCell(name: habit.name,
//                             color: habit.color,
//                             dateString: habit.dateString,
//                             checkToday: habit.isAlreadyTakenToday)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            let habit = HabitsStore.shared.habits[indexPath.item]
            let habitDetailsViewController = HabitDetailsViewController()
//            let habitDetailsViewController = HabitDetailsViewController(index: indexPath.item,
//                                                                        habitTitle: habit.name,
//                                                                        habitColor: habit.color,
//                                                                        habitDate: habit.date,
//                                                                        trackDates: habit.trackDates)
            habitDetailsViewController.getHabit(habit: habit, index: indexPath.item)
            habitDetailsViewController.delegateDelete = self
            habitDetailsViewController.delegateUpdate = self
            navigationController?.pushViewController(habitDetailsViewController, animated: false)
        }
    }

}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight: Int
        switch indexPath.section {
        case 0: cellHeight = 60
        default: cellHeight = 130
        }
        return CGSize(width: Int(view.safeAreaLayoutGuide.layoutFrame.width) - 32, height: cellHeight)
    }
}

//MARK: - My delegates
// добавление привычки
extension HabitsViewController: HabitViewControllerDelegate {

    func didAddNewHabit() {
        self.habitsCollectionView.performBatchUpdates {
            let habitsCount = HabitsStore.shared.habits.count - 1
            self.habitsCollectionView.insertItems(at: [IndexPath(item: habitsCount, section: 1)])
            reloadProgressBar()
        }
    }
}

// удаление привычки
extension HabitsViewController: HabitDetailsViewControllerDelegate {

    func didDeleteHabit(index: Int) {
        self.habitsCollectionView.performBatchUpdates {
            self.habitsCollectionView.deleteItems(at: [IndexPath(item: index, section: 1)])
            reloadProgressBar()
        }
    }
    
}

// обновление прогресса
extension HabitsViewController: HVCProgressUpd {

    func reloadProgressBar() {
        self.habitsCollectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
    }

}

// обновление одной ячейки после редактирования привычки
extension HabitsViewController: DetailVCUpdateDelegate {

    func updateCell(updIndex: Int) {
        self.habitsCollectionView.reloadItems(at: [IndexPath(item: updIndex, section: 1)])
    }

}
