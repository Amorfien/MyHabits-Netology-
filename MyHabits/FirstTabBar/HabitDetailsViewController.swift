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
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var habitTitle = ""
    var habitColor = UIColor.black

    override func viewDidLoad() {
        super.viewDidLoad()
        // сделал фон белым для ландшафтного режима, кодгда чёлка не закрывает таблицу
        view.backgroundColor = .white
//        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)

        setupNavigation()
        setupView()
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
            detailTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func editHabit() {
//        navigationController?.pushViewController(HabitViewController(), animated: true)
        let habitViewController = HabitViewController()
        navigationController?.presentOnRoot(with: habitViewController)
        habitViewController.deleteButton.isHidden = false
        habitViewController.nameTextField.text = habitTitle
        habitViewController.nameTextField.textColor = habitColor
        habitViewController.colorButton.backgroundColor = habitColor
        habitViewController.setTitleForVC(title: "Править")
    }

}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
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
