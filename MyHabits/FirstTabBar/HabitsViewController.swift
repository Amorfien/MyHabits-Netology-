//
//  ViewController.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 17.11.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    private var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        setupNavigation()
        setupUI()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true

//        navigationController?.toolbar.barStyle = .black
        navigationController?.toolbar.isHidden = true
    }

    private func setupNavigation() {
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
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
        let habitViewController = HabitViewController()
        presentOnRoot(with: habitViewController)
        habitViewController.deleteButton.isHidden = true
        habitViewController.setTitleForVC(title: "Создать")
        habitViewController.nameTextField.becomeFirstResponder()
    }
}

extension UIViewController {
    func presentOnRoot(with viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .automatic
        self.present(navigationController, animated: true)
    }
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCell", for: indexPath) as? ProgressCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
                cell.backgroundColor = .systemRed
                return cell
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitsCell", for: indexPath) as? HabitsCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
                cell.backgroundColor = .systemRed
                return cell
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 1 {
            let habitDetailsViewController = HabitDetailsViewController()
            navigationController?.pushViewController(habitDetailsViewController, animated: false)
            let cell = HabitsCollectionViewCell()
            habitDetailsViewController.habitTitle = cell.todoLabel.text ?? ""
            habitDetailsViewController.habitColor = cell.checkButton.tintColor
        }
    }

}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight: Int
        switch indexPath.item {
        case 0: cellHeight = 60
        default: cellHeight = 130
        }
//        return CGSize(width: Int(UIScreen.main.bounds.width) - 32, height: cellHeight)
        return CGSize(width: Int(view.safeAreaLayoutGuide.layoutFrame.width) - 32, height: cellHeight)
//        чтобы при ландшафтном режиме чёлка не перекрывала ячейки
    }
}

