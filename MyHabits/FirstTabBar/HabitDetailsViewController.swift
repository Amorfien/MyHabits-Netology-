//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 19.11.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    private var detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        //tableView.
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["1", "2", "3", "4"]
    }


}
