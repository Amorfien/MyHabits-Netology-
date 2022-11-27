//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 19.11.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    private lazy var detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

//            заполняются данными из ячейки HabitsCollectionViewCell
    private var index = 0
    private var habitTitle = ""
    private var habitColor = UIColor.black

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)

        setupNavigation()
        setupView()
    }

    init(index: Int, habitTitle: String, habitColor: UIColor) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
        self.habitTitle = habitTitle
        self.habitColor = habitColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNavigation() {
        navigationController?.isToolbarHidden = false
        navigationItem.title = habitTitle
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
        let habitViewController = HabitViewController(index: index, navTitle: "Править",
                                                      name: habitTitle, color: habitColor,
                                                      deleteIsHiden: false, isTyping: false)
        navigationController?.presentOnRoot(with: habitViewController)
    }

}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        cell.textLabel?.text = "\(indexPath[1] + 1)"
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }

}
