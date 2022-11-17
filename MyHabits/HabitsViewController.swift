//
//  ViewController.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 17.11.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/257, green: 242/257, blue: 247/257, alpha: 1)
        navigationController?.isToolbarHidden = false
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButton))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 161/257, green: 22/257, blue: 204/257, alpha: 1)

    }

    @objc private func plusButton() {

    }
}

