//
//  TabBarController.swift
//  MyHabits
//
//  Created by Pavel Grigorev on 17.11.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        let habitsViewController = UINavigationController(rootViewController: HabitsViewController())
        let infoViewController = UINavigationController(rootViewController: InfoViewController())

        self.viewControllers = [habitsViewController, infoViewController]
        let item1 = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        let item2 = UITabBarItem(title: "Информация", image:  UIImage(systemName: "info.circle.fill"), tag: 1)
        habitsViewController.tabBarItem = item1
        infoViewController.tabBarItem = item2
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
        UITabBar.appearance().backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        UITabBar.appearance().clipsToBounds = true
    }

}
